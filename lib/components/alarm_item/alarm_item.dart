import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:random_alarm/screens/edit_alarm/edit_alarm.dart';
import 'package:random_alarm/services/alarm_list_manager.dart';
import 'package:random_alarm/stores/alarm_list/alarm_list.dart';
import 'package:random_alarm/stores/observable_alarm/observable_alarm.dart';

const dates = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];

class AlarmItem extends StatelessWidget {
  final ObservableAlarm alarm;
  final AlarmListManager manager;

  const AlarmItem({Key key, @required this.alarm, this.manager}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EditAlarm(alarm: this.alarm, manager: manager))),
      child: Observer(
        builder: (context) => Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(alarm.name),
                    Text(
                      '${alarm.hour.toString().padLeft(2, '0')}:${alarm.minute.toString().padLeft(2, '0')}',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DateRow(alarm: alarm)
                  ],
                ),
                IconButton(
                  icon: alarm.active
                      ? Icon(Icons.alarm, color: Colors.deepOrange)
                      : Icon(Icons.alarm_off),
                  onPressed: () {
                    return alarm.active = !alarm.active;
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DateRow extends StatelessWidget {
  final ObservableAlarm alarm;
  final List<bool> dayEnabled;

  DateRow({
    Key key,
    this.alarm,
  })  : dayEnabled = [
          alarm.monday,
          alarm.tuesday,
          alarm.wednesday,
          alarm.thursday,
          alarm.friday,
          alarm.saturday,
          alarm.sunday
        ],
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size(150, 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: dates.asMap().entries.map((indexStringPair) {
          final dayString = indexStringPair.value;
          final index = indexStringPair.key;
          return Text(
            dayString,
            style: TextStyle(
                fontWeight:
                    dayEnabled[index] ? FontWeight.bold : FontWeight.normal),
          );
        }).toList(),
      ),
    );
  }
}
