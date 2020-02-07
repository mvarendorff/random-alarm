import 'package:flutter/material.dart';
import 'package:random_alarm/stores/observable_alarm/observable_alarm.dart';

class MusicListItem extends StatelessWidget {

  final String musicName;
  final ObservableAlarm alarm;

  const MusicListItem({Key key, this.musicName, this.alarm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(child: Text(this.musicName)),
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => this.alarm.removeItem(musicName),
        )
      ],
    );
  }

}
