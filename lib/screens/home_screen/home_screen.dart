import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:random_alarm/components/alarm_item/alarm_item.dart';
import 'package:random_alarm/components/bottom_add_button/bottom_add_button.dart';
import 'package:random_alarm/components/default_container/default_container.dart';
import 'package:random_alarm/screens/edit_alarm/edit_alarm.dart';
import 'package:random_alarm/services/alarm_list_manager.dart';
import 'package:random_alarm/services/alarm_scheduler.dart';
import 'package:random_alarm/stores/alarm_list/alarm_list.dart';
import 'package:random_alarm/stores/observable_alarm/observable_alarm.dart';

class HomeScreen extends StatelessWidget {
  final AlarmList alarms;

  const HomeScreen({Key key, this.alarms}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  final AlarmListManager _manager = AlarmListManager(alarms);

    return DefaultContainer(
      child: Column(
        children: <Widget>[
          Text(
            'Your alarms',
            style: TextStyle(fontSize: 28, color: Colors.white),
          ),
          Flexible(
            child: Observer(
              builder: (context) => ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final alarm = alarms.alarms[index];

                  return Dismissible(
                    key: Key(alarm.id.toString()),
                    child: AlarmItem(alarm: alarm, manager: _manager),
                    onDismissed: (_) {
                      AlarmScheduler().clearAlarm(alarm);
                      alarms.alarms.removeAt(index);
                    },
                  );
                },
                itemCount: alarms.alarms.length,
                separatorBuilder: (context, index) => const Divider(),
              ),
            ),
          ),
          BottomAddButton(
            onPressed: () {
              TimeOfDay tod = TimeOfDay.fromDateTime(DateTime.now());
              final newAlarm = ObservableAlarm.dayList(
                alarms.alarms.length,
                'New Alarm',
                tod.hour,
                tod.minute,
                0.3,
                true,
                List.filled(7, false),
                ObservableList<String>.of([]),
                <String>[]
              );
              alarms.alarms.add(newAlarm);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditAlarm(alarm: newAlarm, manager: _manager,),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
