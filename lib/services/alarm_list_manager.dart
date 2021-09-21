import 'file_proxy.dart';
import '../stores/alarm_list/alarm_list.dart';
import '../stores/observable_alarm/observable_alarm.dart';

class AlarmListManager {
  final AlarmList _alarms;
  final JsonFileStorage _storage = JsonFileStorage();

  AlarmListManager(this._alarms);

  saveAlarm(ObservableAlarm alarm) async {
    await alarm.updateMusicPaths();
    final index =
        _alarms.alarms.indexWhere((findAlarm) => alarm.id == findAlarm.id);
    _alarms.alarms[index] = alarm;
    await _storage.writeList(_alarms.alarms);
  }
}
