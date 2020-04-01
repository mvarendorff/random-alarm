import 'dart:io';
import 'dart:math';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:random_alarm/services/file_proxy.dart';
import 'package:random_alarm/stores/observable_alarm/observable_alarm.dart';
import 'package:volume/volume.dart';

//TODO unschedule if alarm is turned off
//TODO Reschedule if days are changed
class AlarmScheduler {
  void testAlarm() async {
    await AndroidAlarmManager.oneShot(Duration(seconds: 5), 0, callback);
  }

  /*
    To wake up the device and run something on top of the lockscreen,
    this currently requires the hack from here to be implemented:
    https://github.com/flutter/flutter/issues/30555#issuecomment-501597824
  */
  Future<void> scheduleAlarm(ObservableAlarm alarm) async {
    final days = alarm.days;

    final scheduleId = alarm.id * 7;
    for (var i = 0; i < 7; i++) {
      if (days[i]) {
        final targetDateTime = nextWeekday(i + 1, alarm.hour, alarm.minute);
        await AndroidAlarmManager.oneShotAt(
            targetDateTime, scheduleId + i, callback,
            alarmClock: true, rescheduleOnReboot: true);
      }
    }
  }

  DateTime nextWeekday(int weekday, alarmHour, alarmMinute) {
    var checkedDay = DateTime.now();

    if (checkedDay.weekday == weekday) {
      final todayAlarm = DateTime(checkedDay.year, checkedDay.month,
          checkedDay.day, alarmHour, alarmMinute);

      if (checkedDay.isBefore(todayAlarm)) {
        return todayAlarm;
      }
      return todayAlarm.add(Duration(days: 7));
    }

    while (checkedDay.weekday != weekday) {
      checkedDay = checkedDay.add(Duration(days: 1));
    }

    return DateTime(checkedDay.year, checkedDay.month, checkedDay.day,
        alarmHour, alarmMinute);
  }

  static void callback(int id) async {
    final extPath = await getExternalStorageDirectory().then((dir) => dir.path);
    final alarmId = callbackToAlarmId(id);

    print('External Path under $extPath');
    final file = File("$extPath/callbacklog_$alarmId.log");

    if (file.existsSync()) {
      file.deleteSync();
    }

    file.createSync();

    file.writeAsString("Callback with ID $id called; working with alarm ID $alarmId!\n", mode: FileMode.append);

    createAlarmFlag(alarmId);

    List<ObservableAlarm> alarms = await JsonFileStorage().readList();

    print('Attemping to load the alarm with ID $alarmId');
    alarms.map((alarm) => alarm.id).forEach((id) => print("Available ID: $id"));

    final alarm =
        alarms.firstWhere((alarm) => alarm.id == alarmId, orElse: () => null);
    if (alarm == null) return; //Just for testing for now.

    file.writeAsString("Alarm details: ${alarm.toJson().toString()}\n", mode: FileMode.append);
    file.writeAsString("Current time: ${DateTime.now().hour}:${DateTime.now().minute}\n", mode: FileMode.append);

    final paths = alarm.musicPaths;

    final entry = Random().nextInt(paths.length);
    final path = paths[entry];

    print("Selected path: $path");

    //If empty, get default ringtone
    //Pick a random path, pass it to the player; for testing just print it
    AudioPlayer player = AudioPlayer();
    print('Started playing audio');
    player.play(path, isLocal: true, volume: 1.0);

    file.writeAsString("Looking for disable file under ${alarm.id}.disable\n", mode: FileMode.append);
    pollForAlarmOff(player, alarmId);
  }

  static Future<int> getNewVolume(double percentage) async {
    final max = await Volume.getMaxVol;
    return (max * percentage).toInt();
  }

  /// Because each alarm might need to be able to schedule up to 7 android alarms (for each weekday)
  /// a means is required to convert from the actual callback ID to the ID of the alarm saved
  /// in internal storage. To do so, we can assign a range of 7 per alarm and use ceil to get to
  /// get the alarm ID to access the list of songs that could be played
  static int callbackToAlarmId(int callbackId) {
    return (callbackId / 7).floor();
  }

  /// Creates a flag file that the main isolate can find on life cycle change
  /// For now just abusing the FileProxy class for testing
  static void createAlarmFlag(int id) async {
    print('Creating a new alarm flag for ID $id');
    final dir = await getApplicationDocumentsDirectory();
    JsonFileStorage.toFile(File(dir.path + "/$id.alarm")).writeList([]);
  }

  /// Method that runs polls until one of the following things happens:
  ///  - The player emits a completion event
  ///  - A file called <id>.disable is found in getApplicationDocumentsDirectory
  static void pollForAlarmOff(AudioPlayer player, int id) async {
    var running = true;
    final dir = await getApplicationDocumentsDirectory();
    final searchPath = '$id.disable';

    player.onPlayerCompletion.listen((data) => running = false);

    while (running) {
      final foundFile = await dir
          .list()
          .map((entry) => entry.path)
          .any((path) => basename(path) == searchPath);

      if (foundFile) {
        player.stop();
        File(dir.path + "/$searchPath").delete();
        running = false;
      }

      sleep(Duration(seconds: 1));
    }
  }
}
