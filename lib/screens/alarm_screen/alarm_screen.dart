import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:random_alarm/components/default_container/default_container.dart';
import 'package:intl/intl.dart';
import 'package:random_alarm/services/file_proxy.dart';
import 'package:random_alarm/stores/alarm_status/alarm_status.dart';
import 'package:slide_button/slide_button.dart';

class AlarmScreen extends StatelessWidget {
  final String alarmName;

  const AlarmScreen({Key key, this.alarmName}) : super(key: key);

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
                    alarmName,
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
                AlarmStatus().isAlarm = false;
                final dir = await getApplicationDocumentsDirectory();
                final id = AlarmStatus().alarmId;
                if (id == null) return;

                AlarmStatus().alarmId = null;
                print('Creating disable file for ID: $id');
                JsonFileStorage.toFile(File(dir.path + "/$id.disable")).writeList([]);
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
