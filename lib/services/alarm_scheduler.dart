import 'package:android_alarm_manager/android_alarm_manager.dart';

class AlarmScheduler {
  void testAlarm() async {
    print('Initialize AlarmService');
    await AndroidAlarmManager.initialize().then(print);
    print('Setting oneShot');
    /*
      To wake up the device and run something on top of the lockscreen,
      this currently requires the hack from here to be implemented:
      https://github.com/flutter/flutter/issues/30555#issuecomment-501597824
    */
    await AndroidAlarmManager.oneShot(
            Duration(seconds: 10), 42, callback, wakeup: true)
        .then(print);
  }

  static void callback(int id) {
    print(id);
  }

}
