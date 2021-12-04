import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../stores/alarm_list/alarm_list.dart';
import 'alarm_polling_worker.dart';
import 'file_proxy.dart';

class LifeCycleListener extends WidgetsBindingObserver {
  LifeCycleListener();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
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
    final AlarmList alarms = Get.find();
    alarms.alarms.forEach((alarm) => alarm.updateMusicPaths());
    JsonFileStorage().writeList(alarms.alarms);
  }

  void createAlarmPollingIsolate() {
    print('Creating a new worker to check for alarm files!');
    AlarmPollingWorker().createPollingWorker();
  }
}
