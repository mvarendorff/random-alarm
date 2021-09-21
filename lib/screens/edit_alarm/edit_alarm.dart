import 'package:flutter/material.dart';
import '../../components/default_container/default_container.dart';
import 'components/edit_alarm_days.dart';
import 'components/edit_alarm_head.dart';
import 'components/edit_alarm_music.dart';
import 'components/edit_alarm_slider.dart';
import 'components/edit_alarm_time.dart';
import '../../services/alarm_list_manager.dart';
import '../../services/alarm_scheduler.dart';
import '../../stores/observable_alarm/observable_alarm.dart';

class EditAlarm extends StatelessWidget {
  final ObservableAlarm alarm;
  final AlarmListManager manager;

  EditAlarm({required this.alarm, required this.manager});

  @override
  Widget build(BuildContext context) {
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
                    EditAlarmHead(alarm: this.alarm),
                    Divider(),
                    EditAlarmTime(alarm: this.alarm),
                    Divider(),
                    EditAlarmDays(alarm: this.alarm),
                    Divider(),
                    EditAlarmMusic(alarm: this.alarm),
                    Divider(),
                    EditAlarmSlider(alarm: this.alarm)
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
