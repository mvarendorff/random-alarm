import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:random_alarm/components/music_selection_dialog/music_selection_dialog.dart';
import 'package:random_alarm/screens/edit_alarm/components/music_list_item.dart';
import 'package:random_alarm/stores/observable_alarm/observable_alarm.dart';

class EditAlarmMusic extends StatelessWidget {
  final ObservableAlarm alarm;

  const EditAlarmMusic({Key key, this.alarm}) : super(key: key);

  void openDialog(context) async {
    final audioQuery = FlutterAudioQuery();
    final songs =
        await audioQuery.getSongs(sortType: SongSortType.DISPLAY_NAME);
    showDialog(
        context: context,
        child: MusicSelectionDialog(alarm: alarm, titles: songs));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Selection',
              style: TextStyle(fontSize: 20),
            ),
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.deepPurple,
              ),
              onPressed: () => openDialog(context),
            )
          ],
        ),
        SizedBox.fromSize(
          size: Size.fromHeight(300),
          child: Observer(
            builder: (context) => ReorderableListView(
                children: this
                    .alarm
                    .trackInfo
                    .map((title) => MusicListItem(
                          alarm: alarm,
                          musicInfo: title,
                          key: Key(title.id),
                        ))
                    .toList(),
                onReorder: this.alarm.reorder,
              ),
          ),
        ),
      ],
    );
  }
}
