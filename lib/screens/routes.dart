import 'package:random_alarm/screens/alarm/alarm_screen.dart';
import 'package:random_alarm/screens/edit/edit_alarm.dart';
import 'package:random_alarm/stores/observable_alarm/observable_alarm.dart';

import 'home/home.dart';

class AlarmArguments {
  final ObservableAlarm alarm;
  AlarmArguments(this.alarm);
}

class RoutesDefinition {
  static final routes = {
    HomeScreen.routeName: (_) => HomeScreen(),
    AlarmScreen.routeName: (_) => AlarmScreen(),
    EditAlarm.routeName: (_) => EditAlarm(),
  };
}
