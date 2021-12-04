import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:random_alarm/screens/routes.dart';

import 'services/alarm_polling_worker.dart';
import 'services/file_proxy.dart';
import 'services/life_cycle_listener.dart';
import 'stores/alarm_list/alarm_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(JsonFileStorage());

  final alarmList = AlarmList();
  await alarmList.initialize();
  Get.put(alarmList);

  WidgetsBinding.instance!.addObserver(LifeCycleListener());

  runApp(MyApp());

  await AndroidAlarmManager.initialize();
  AlarmPollingWorker().createPollingWorker();

  final externalPath = await getExternalStorageDirectory();
  if (externalPath == null) {
    return;
  }

  if (!externalPath.existsSync()) {
    externalPath.create(recursive: true);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Alarm',
      routes: RoutesDefinition.routes,
      initialRoute: "/",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color.fromRGBO(25, 12, 38, 1),
      ),
      // home: Builder(
      //   builder: (context) {
      //     AlarmStatus status = AlarmStatus();
      //
      //     if (status.isAlarm.isTrue) {
      //       final id = status.alarmId;
      //       final alarm =
      //           list.alarms.firstWhereOrNull((alarm) => alarm.id == id)!;
      //
      //       MediaHandler mediaHandler = MediaHandler();
      //
      //       mediaHandler.changeVolume(alarm);
      //       mediaHandler.playMusic(alarm);
      //       Wakelock.enable();
      //
      //       return AlarmScreen(alarm: alarm, mediaHandler: mediaHandler);
      //     }
      //
      //     return HomeScreen();
      //   },
      // ),
    );
  }
}
