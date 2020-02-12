import 'dart:math';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:random_alarm/services/file_proxy.dart';
import 'package:random_alarm/stores/observable_alarm/observable_alarm.dart';

//TODO unschedule if alarm is turned off
//TODO Reschedule if days are changed
class AlarmScheduler {
  /*
    To wake up the device and run something on top of the lockscreen,
    this currently requires the hack from here to be implemented:
    https://github.com/flutter/flutter/issues/30555#issuecomment-501597824
  */
  Future<void> scheduleAlarm(ObservableAlarm alarm) async {
    final days = alarm.days;

    final scheduleId = (alarm.id - 1) * 7;
    for (var i = 0; i < 7; i++) {
      if (days[i]) {
        final targetDateTime = nextWeekday(i + 1, alarm.hour, alarm.minute);
        print('Scheduling new alarm for $targetDateTime!');
        await AndroidAlarmManager.oneShotAt(
            targetDateTime, scheduleId + i, callback);
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
    //Load selected paths
    List<ObservableAlarm> alarms = await JsonFileStorage().readList();

    final alarmId = callbackToAlarmId(id);

    final alarm = alarms.firstWhere((alarm) => alarm.id == alarmId);
    await alarm.loadTracks();
    final selectedPaths = alarm.trackInfo;

    final entry = Random().nextInt(selectedPaths.length);
    final path = selectedPaths[entry].filePath;

    print("Selected path: $path");

    //If empty, get default ringtone
    //Pick a random path, pass it to the player; for testing just print it
    AudioPlayer player = AudioPlayer();
    player.play(path, isLocal: true, volume: alarm.volume);
  }

  /// Because each alarm might need to be able to schedule up to 7 android alarms (for each weekday)
  /// a means is required to convert from the actual callback ID to the ID of the alarm saved
  /// in internal storage. To do so, we can assign a range of 7 per alarm and use ceil to get to
  /// get the alarm ID to access the list of songs that could be played
  static int callbackToAlarmId(int callbackId) {
    return (callbackId / 7).ceil();
  }
}
