import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:random_alarm/stores/observable_alarm/observable_alarm.dart';

class MusicListItem extends StatelessWidget {

  final SongInfo musicInfo;
  final ObservableAlarm alarm;

  const MusicListItem({Key key, this.musicInfo, this.alarm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Icon(Icons.music_note),
        Expanded(child: Text(this.musicInfo.title ?? this.musicInfo.displayName)),
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => this.alarm.removeItem(musicInfo),
        )
      ],
    );
  }

}
