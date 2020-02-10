import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:random_alarm/stores/observable_alarm/observable_alarm.dart';

class EditAlarmTime extends StatelessWidget {
  final ObservableAlarm alarm;

  const EditAlarmTime({Key key, this.alarm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Observer(
            builder: (context) {
              final hours = alarm.hour.toString().padLeft(2, '0');
              final minutes = alarm.minute.toString().padLeft(2, '0');
              return Text('$hours:$minutes', style: TextStyle(fontSize: 48),);
            }),
        onTap: () async {
          final time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay(hour: alarm.hour, minute: alarm.minute));
          alarm.hour = time.hour;
          alarm.minute = time.minute;
        },
      ),
    );
  }
}
