import 'package:mobx/mobx.dart';

part 'alarm_status.g.dart';

class AlarmStatus extends _AlarmStatus with _$AlarmStatus {

  static final AlarmStatus _instance = AlarmStatus._();

  factory AlarmStatus() {
    return _instance;
  }

  AlarmStatus._();

}

abstract class _AlarmStatus with Store {

  @observable
  bool isAlarm = false;

  int alarmId;

}
