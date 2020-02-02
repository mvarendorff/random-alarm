import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:random_alarm/screens/edit_alarm/edit_alarm.dart';
import 'package:random_alarm/stores/observable_alarm/observable_alarm.dart';

const dates = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];

class AlarmItem extends StatelessWidget {
  final ObservableAlarm alarm;

  const AlarmItem({Key key, @required this.alarm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EditAlarm(alarm: this.alarm))),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: dates.map((x) => Text(x)).toList(),
                    )
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
