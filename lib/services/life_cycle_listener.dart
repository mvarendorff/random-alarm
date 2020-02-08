import 'package:flutter/material.dart';
import 'package:random_alarm/services/file_proxy.dart';
import 'package:random_alarm/stores/alarm_list/alarm_list.dart';

class LifeCycleListener extends WidgetsBindingObserver {

  final AlarmList alarms;

  LifeCycleListener(this.alarms);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        alarms.alarms.forEach((alarm) => alarm.updateMusicPaths());
        JsonFileStorage().writeList(alarms.alarms);
        break;
      default:
    }
  }

}