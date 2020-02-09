import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:random_alarm/services/file_proxy.dart';

class AlarmScheduler {
  void testAlarm() async {
    await AndroidAlarmManager.initialize().then(print);
    print('Should do something in 3 seconds');
    await AndroidAlarmManager.oneShot(
            Duration(minutes: 1), 42, callback,
            wakeup: true)
        .then(print);
  }

  static void callback(int id) {
    print(id);
    JsonFileStorage.toFile(File("/sdcard/Music/file.app")).writeList([]);
    print('This should work now?');
  }

}
