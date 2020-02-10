import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:random_alarm/services/file_proxy.dart';

class AlarmScheduler {
  void testAlarm() async {
    print('Initialize AlarmService');
    await AndroidAlarmManager.initialize().then(print);
    print('Setting oneShot');
    await AndroidAlarmManager.oneShot(
            Duration(seconds: 3), 42, callback)
        .then(print);
  }

  static void callback(int id) {
    print(id);
    JsonFileStorage.toFile(File("/sdcard/Music/file.app")).writeList([]);
    print('This should work now?');
  }

}
