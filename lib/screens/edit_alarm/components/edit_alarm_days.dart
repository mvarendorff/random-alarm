import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../stores/observable_alarm/observable_alarm.dart';

class EditAlarmDays extends StatelessWidget {
  final ObservableAlarm alarm;

  const EditAlarmDays({Key? key, required this.alarm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          WeekDayToggle(
            text: 'Mo',
            current: alarm.monday,
            onToggle: (monday) => alarm.monday = monday,
          ),
          WeekDayToggle(
            text: 'Tu',
            current: alarm.tuesday,
            onToggle: (tuesday) => alarm.tuesday = tuesday,
          ),
          WeekDayToggle(
            text: 'We',
            current: alarm.wednesday,
            onToggle: (wednesday) => alarm.wednesday = wednesday,
          ),
          WeekDayToggle(
            text: 'Th',
            current: alarm.thursday,
            onToggle: (thursday) => alarm.thursday = thursday,
          ),
          WeekDayToggle(
            text: 'Fr',
            current: alarm.friday,
            onToggle: (friday) => alarm.friday = friday,
          ),
          WeekDayToggle(
            text: 'Sa',
            current: alarm.saturday,
            onToggle: (saturday) => alarm.saturday = saturday,
          ),
          WeekDayToggle(
            text: 'Su',
            current: alarm.sunday,
            onToggle: (sunday) => alarm.sunday = sunday,
          ),
        ],
      ),
    );
  }
}

class WeekDayToggle extends StatelessWidget {
  final void Function(bool) onToggle;
  final bool current;
  final String text;

  const WeekDayToggle({Key? key, required this.onToggle, required this.current, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const size = 20.0;
    final textColor = this.current ? Colors.white : Colors.deepPurple;
    final blobColor = this.current ? Colors.deepPurple : Colors.white;

    return GestureDetector(
      child: SizedBox.fromSize(
        size: Size.fromRadius(size),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: new BorderRadius.circular(size), color: blobColor),
          child: Center(
              child: Text(
            this.text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          )),
        ),
      ),
      onTap: () => this.onToggle(!this.current),
    );
  }
}
