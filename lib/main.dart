import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:random_alarm/screens/alarm_screen/alarm_screen.dart';
import 'package:random_alarm/screens/home_screen/home_screen.dart';
import 'package:random_alarm/services/alarm_polling_worker.dart';
import 'package:random_alarm/services/file_proxy.dart';
import 'package:random_alarm/services/life_cycle_listener.dart';
import 'package:random_alarm/services/media_handler.dart';
import 'package:random_alarm/stores/alarm_list/alarm_list.dart';
import 'package:random_alarm/stores/alarm_status/alarm_status.dart';
import 'package:volume/volume.dart';
import 'package:wakelock/wakelock.dart';

AlarmList list = AlarmList();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final alarms = await new JsonFileStorage().readList();
  list.setAlarms(alarms);
  list.alarms.forEach((alarm) {
    alarm.loadTracks();
    alarm.loadPlaylists();
  });
  WidgetsBinding.instance.addObserver(LifeCycleListener(list));

  runApp(MyApp());
  await AndroidAlarmManager.initialize();
  AlarmPollingWorker().createPollingWorker();

  final externalPath = (await getExternalStorageDirectory());
  print(externalPath.path);
  if (!externalPath.existsSync()) externalPath.create(recursive: true);

  Volume.controlVolume(AudioManager.STREAM_MUSIC);
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
            final alarm = list.alarms
                .firstWhere((alarm) => alarm.id == id, orElse: () => null);

            MediaHandler mediaHandler = MediaHandler();

            mediaHandler.changeVolume(alarm);
            mediaHandler.playMusic(alarm);
            Wakelock.enable();

            return AlarmScreen(
                alarm: alarm,
                mediaHandler: mediaHandler);
          }
          return HomeScreen(alarms: list);
        }));
  }
}
