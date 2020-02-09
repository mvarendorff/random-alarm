import 'package:flutter/material.dart';
import 'package:random_alarm/services/alarm_scheduler.dart';
import 'package:random_alarm/services/file_proxy.dart';
import 'package:random_alarm/stores/alarm_list/alarm_list.dart';

class LifeCycleListener extends WidgetsBindingObserver {
  final AlarmList alarms;

  LifeCycleListener(this.alarms);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.paused:
        AlarmScheduler().testAlarm();
        saveAlarms();
        break;
      default:
    }
  }

  void saveAlarms() {
    alarms.alarms.forEach((alarm) => alarm.updateMusicPaths());
    JsonFileStorage().writeList(alarms.alarms);
  }
}
