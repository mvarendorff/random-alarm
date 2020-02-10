import 'package:mobx/mobx.dart';
import 'package:random_alarm/stores/observable_alarm/observable_alarm.dart';

part 'alarm_list.g.dart';

class AlarmList = _AlarmList with _$AlarmList;

abstract class _AlarmList with Store {

  _AlarmList();

  @observable
  ObservableList<ObservableAlarm> alarms = ObservableList();

  @action
  void setAlarms(List<ObservableAlarm> alarms) {
    this.alarms.clear();
    this.alarms.addAll(alarms);
  }

}
