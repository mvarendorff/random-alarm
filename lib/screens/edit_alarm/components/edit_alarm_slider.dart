import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../stores/observable_alarm/observable_alarm.dart';

class EditAlarmSlider extends StatelessWidget {
  final ObservableAlarm alarm;

  const EditAlarmSlider({Key? key, required this.alarm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => Slider(
        value: alarm.volume,
        min: 0,
        max: 1,
        onChanged: (newVolume) => this.alarm.volume = newVolume,
      ),
    );
  }
}
