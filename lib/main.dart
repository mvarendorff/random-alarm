import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wakelock/wakelock.dart';

import 'screens/alarm_screen/alarm_screen.dart';
import 'screens/home_screen/home_screen.dart';
import 'services/alarm_polling_worker.dart';
import 'services/file_proxy.dart';
import 'services/life_cycle_listener.dart';
import 'services/media_handler.dart';
import 'stores/alarm_list/alarm_list.dart';
import 'stores/alarm_status/alarm_status.dart';

AlarmList list = AlarmList();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final alarms = await new JsonFileStorage().readList();
  list.setAlarms(alarms);
  list.alarms.forEach((alarm) {
    alarm.loadTracks();
    alarm.loadPlaylists();
  });
  WidgetsBinding.instance!.addObserver(LifeCycleListener(list));

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
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Color.fromRGBO(25, 12, 38, 1),
        ),
        home: Observer(builder: (context) {
          AlarmStatus status = AlarmStatus();

          if (status.isAlarm) {
            final id = status.alarmId;
            final alarm =
                list.alarms.firstWhereOrNull((alarm) => alarm.id == id)!;

            MediaHandler mediaHandler = MediaHandler();

            mediaHandler.changeVolume(alarm);
            mediaHandler.playMusic(alarm);
            Wakelock.enable();

            return AlarmScreen(alarm: alarm, mediaHandler: mediaHandler);
          }
          return HomeScreen(alarms: list);
        }));
  }
}
