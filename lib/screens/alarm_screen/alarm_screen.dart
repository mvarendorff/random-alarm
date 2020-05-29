import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:random_alarm/components/default_container/default_container.dart';
import 'package:random_alarm/services/media_handler.dart';
import 'package:random_alarm/stores/alarm_status/alarm_status.dart';
import 'package:random_alarm/stores/observable_alarm/observable_alarm.dart';
import 'package:slide_button/slide_button.dart';
import 'package:wakelock/wakelock.dart';

class AlarmScreen extends StatelessWidget {
  final ObservableAlarm alarm;
  final MediaHandler mediaHandler;

  const AlarmScreen({Key key, this.alarm, this.mediaHandler}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final format = DateFormat('Hm');

    return DefaultContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
            child: Container(
              width: 325,
              height: 325,
              decoration: ShapeDecoration(
                  shape: CircleBorder(
                      side: BorderSide(
                          color: Colors.deepOrange,
                          style: BorderStyle.solid,
                          width: 4))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(
                    Icons.alarm,
                    color: Colors.deepOrange,
                    size: 32,
                  ),
                  Text(
                    format.format(now),
                    style: TextStyle(
                        fontSize: 52,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  ),
                  Text(
                    alarm?.name,
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ],
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: SlideButton(
              height: 80,
              slidingChild: Center(
                  child: Icon(
                Icons.chevron_right,
                size: 36,
              )),
              backgroundChild: Center(
                  child: Text(
                'Turn off alarm!',
                style: TextStyle(fontSize: 26),
              )),
              onButtonOpened: () async {
                mediaHandler.stopAlarm();
                Wakelock.disable();

                AlarmStatus().isAlarm = false;
                AlarmStatus().alarmId = null;
                SystemNavigator.pop();
              },
              slidingBarColor: Colors.deepPurple,
              backgroundColor: Colors.deepOrangeAccent,
            ),
          )
        ],
      ),
    );
  }
}
