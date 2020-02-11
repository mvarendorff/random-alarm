import 'package:android_alarm_manager/android_alarm_manager.dart';

class AlarmScheduler {
  void testAlarm() async {
    print('Initialize AlarmService');
    await AndroidAlarmManager.initialize().then(print);
    print('Setting oneShot');
    await AndroidAlarmManager.oneShot(
            Duration(seconds: 10), 42, callback, wakeup: true)
        .then(print);
  }

  static void callback(int id) {
    print(id);
  }

}
