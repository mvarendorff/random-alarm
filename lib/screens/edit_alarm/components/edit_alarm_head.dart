import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:random_alarm/stores/observable_alarm/observable_alarm.dart';

class EditAlarmHead extends StatelessWidget {
  final ObservableAlarm alarm;

  EditAlarmHead({this.alarm});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Name:'),
              TextField(
                decoration: InputDecoration(border: InputBorder.none),
                controller: TextEditingController(text: alarm.name),
                style: TextStyle(fontSize: 18),
                onChanged: (newName) => alarm.name = newName,
              )
            ],
          ),
        ),
        Observer(
          builder: (context) => IconButton(
            icon: alarm.active
                ? Icon(Icons.alarm, color: Colors.deepOrange)
                : Icon(Icons.alarm_off),
            onPressed: () => alarm.active = !alarm.active,
          ),
        )
      ],
    );
  }
}
