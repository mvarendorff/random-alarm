import 'package:get/get.dart';
import 'package:random_alarm/services/file_proxy.dart';

import '../observable_alarm/observable_alarm.dart';

class AlarmList {
  AlarmList();

  List<ObservableAlarm> alarms = <ObservableAlarm>[].obs;

  Future<void> initialize() async {
    final JsonFileStorage storage = Get.find();
    final alarms = await storage.readList();
    _setAlarms(alarms);

    await Future.wait(alarms.map(_loadAlarm));
  }

  void _setAlarms(List<ObservableAlarm> alarms) {
    this.alarms.clear();
    this.alarms.addAll(alarms);
  }

  Future<void> _loadAlarm(ObservableAlarm alarm) async {
    await alarm.loadTracks();
    await alarm.loadPlaylists();
  }
}
