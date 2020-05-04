import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:random_alarm/stores/observable_alarm/observable_alarm.dart';

class PlaylistListItem extends StatelessWidget {

  final PlaylistInfo playlistInfo;
  final ObservableAlarm alarm;

  const PlaylistListItem({Key key, this.playlistInfo, this.alarm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Icon(Icons.list),
        Expanded(child: Text(this.playlistInfo.name)),
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => this.alarm.removePlaylist(playlistInfo),
        )
      ],
    );
  }

}
