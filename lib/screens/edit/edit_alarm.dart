import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_alarm/screens/routes.dart';

import '../../components/default_container/default_container.dart';
import '../../services/alarm_list_manager.dart';
import '../../services/alarm_scheduler.dart';
import 'components/edit_alarm_days.dart';
import 'components/edit_alarm_head.dart';
import 'components/edit_alarm_music.dart';
import 'components/edit_alarm_slider.dart';
import 'components/edit_alarm_time.dart';

class EditAlarm extends StatelessWidget {
  static const routeName = "/edit";

  @override
  Widget build(BuildContext context) {
    final FileStorageManager manager = Get.find();
    final alarm = (Get.arguments as AlarmArguments).alarm;

    return WillPopScope(
      onWillPop: () async {
        await manager.saveAlarm(alarm);
        await AlarmScheduler().scheduleAlarm(alarm);
        return true;
      },
      child: DefaultContainer(
        child: SingleChildScrollView(
          child: Column(children: [
            Text(
              'Alarm',
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    EditAlarmHead(alarm: alarm),
                    Divider(),
                    EditAlarmTime(alarm: alarm),
                    Divider(),
                    EditAlarmDays(alarm: alarm),
                    Divider(),
                    EditAlarmMusic(alarm: alarm),
                    Divider(),
                    EditAlarmSlider(alarm: alarm),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
