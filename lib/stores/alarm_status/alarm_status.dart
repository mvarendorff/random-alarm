import 'package:get/get.dart';

class AlarmStatus {
  RxBool isAlarm = false.obs;
  Rx<int?> alarmId = null.obs;

  void setAlarmFound(int id) {
    isAlarm.value = true;
    alarmId.value = id;
  }

  void turnOff() {
    isAlarm.value = false;
    alarmId.value = null;
  }
}
