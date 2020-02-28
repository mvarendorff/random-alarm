import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:random_alarm/screens/alarm_screen/alarm_screen.dart';
import 'package:random_alarm/screens/home_screen/home_screen.dart';
import 'package:random_alarm/services/alarm_polling_isolate_manager.dart';
import 'package:random_alarm/services/file_proxy.dart';
import 'package:random_alarm/services/life_cycle_listener.dart';
import 'package:random_alarm/stores/alarm_list/alarm_list.dart';
import 'package:random_alarm/stores/alarm_status/alarm_status.dart';

AlarmList list = AlarmList();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final alarms = await new JsonFileStorage().readList();
  list.setAlarms(alarms);
  list.alarms.forEach((alarm) => alarm.loadTracks());
  WidgetsBinding.instance.addObserver(LifeCycleListener(list));

  runApp(MyApp());
  await AndroidAlarmManager.initialize();
  AlarmPollingWorker().createPollingWorker();
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
          print("Recreating the home screen! isAlarm: ${status.isAlarm}");
          if (status.isAlarm) {
            final id = status.alarmId;
            final alarm = list.alarms
                .firstWhere((alarm) => alarm.id == id, orElse: () => null);

            final alarmName = alarm?.name ?? "";
            return AlarmScreen(alarmName: alarmName);
          }
          return HomeScreen(alarms: list);
        }));
  }
}
