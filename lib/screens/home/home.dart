import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_alarm/screens/edit/edit_alarm.dart';
import 'package:random_alarm/screens/routes.dart';

import '../../components/alarm_item/alarm_item.dart';
import '../../components/bottom_add_button/bottom_add_button.dart';
import '../../components/default_container/default_container.dart';
import '../../services/alarm_list_manager.dart';
import '../../services/alarm_scheduler.dart';
import '../../stores/alarm_list/alarm_list.dart';
import '../../stores/observable_alarm/observable_alarm.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AlarmList alarms = Get.find();
    final FileStorageManager _manager = FileStorageManager(alarms);

    return DefaultContainer(
      child: Column(
        children: <Widget>[
          Text(
            'Your alarms',
            style: TextStyle(fontSize: 28, color: Colors.white),
          ),
          Flexible(
            child: Builder(
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
                [],
                [],
              );
              alarms.alarms.add(newAlarm);

              Get.to(EditAlarm.routeName, arguments: AlarmArguments(newAlarm));
            },
          )
        ],
      ),
    );
  }
}
