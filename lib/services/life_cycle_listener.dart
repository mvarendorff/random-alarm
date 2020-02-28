import 'package:flutter/material.dart';
import 'package:random_alarm/services/alarm_polling_isolate_manager.dart';
import 'package:random_alarm/services/file_proxy.dart';
import 'package:random_alarm/stores/alarm_list/alarm_list.dart';

class LifeCycleListener extends WidgetsBindingObserver {
  final AlarmList alarms;

  LifeCycleListener(this.alarms);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.paused:
        saveAlarms();
        break;
      case AppLifecycleState.resumed:
        createAlarmPollingIsolate();
        break;
      default:
        print("Updated lifecycle state: $state");
    }
  }

  void saveAlarms() {
    alarms.alarms.forEach((alarm) => alarm.updateMusicPaths());
    JsonFileStorage().writeList(alarms.alarms);
  }

  void createAlarmPollingIsolate() {
    print('Creating a new worker to check for alarm files!');
    AlarmPollingWorker().createPollingWorker();
  }
}
