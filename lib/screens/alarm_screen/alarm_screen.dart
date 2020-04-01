import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:random_alarm/components/default_container/default_container.dart';
import 'package:intl/intl.dart';
import 'package:random_alarm/services/file_proxy.dart';
import 'package:random_alarm/stores/alarm_status/alarm_status.dart';
import 'package:random_alarm/stores/observable_alarm/observable_alarm.dart';
import 'package:slide_button/slide_button.dart';
import 'package:volume/volume.dart';

class AlarmScreen extends StatelessWidget {
  final ObservableAlarm alarm;
  final Future<int> originalVolume;

  const AlarmScreen({Key key, this.alarm, this.originalVolume}) : super(key: key);

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
                final externalPath = (await getExternalStorageDirectory()).path;
                final id = alarm.id;

                final logFile = File(externalPath + "/$id.alarm_screen.log");

                if (logFile.existsSync()) {
                  logFile.deleteSync();
                }

                logFile.createSync();

                logFile.writeAsStringSync("[INFO / alarmID: $id] - Button opened on alarm screen\n", mode: FileMode.writeOnlyAppend);

                if (id == null) {
                  print("Returning because of null ID");
                  logFile.writeAsString("[INFO / alarmID: $id] - The ID is null for some reason; exiting the resulting function!\n", mode: FileMode.append);
                  return;
                }

                logFile.writeAsString("[INFO / alarmID: $id] - Getting application documents directory\n", mode: FileMode.append);
                final dir = await getApplicationDocumentsDirectory();

                logFile.writeAsString('[INFO / alarmID: $id] - Creating disable file for ID: $id\n', mode: FileMode.append);
                JsonFileStorage.toFile(File(dir.path + "/$id.disable")).writeList([]);

                logFile.writeAsString('[INFO / alarmID: $id] - Disable file written; getting original volume from promise');

                //TODO find out why this is not running!
                final int returnVolume = await originalVolume;
                logFile.writeAsString('[INFO / alarmID: $id] - Music stopped! Resetting volume back to $returnVolume\n', mode: FileMode.append);
                Volume.setVol(returnVolume);

                logFile.writeAsString('[INFO / alarmID: $id] - Setting "isAlarm" back to false, "alarmId" back to null and closing the app.\n', mode: FileMode.append);
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
