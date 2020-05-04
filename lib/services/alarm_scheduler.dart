import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:random_alarm/services/file_proxy.dart';
import 'package:random_alarm/stores/observable_alarm/observable_alarm.dart';

class AlarmScheduler {

  clearAlarm(ObservableAlarm alarm) {
    for (var i = 0; i < 7; i++) {
      AndroidAlarmManager.cancel(alarm.id * 7 + i);
    }
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
      await AndroidAlarmManager.cancel(scheduleId + i);
      if (alarm.active && days[i]) {
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
    final alarmId = callbackToAlarmId(id);

    createAlarmFlag(alarmId);
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

}
