import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:random_alarm/components/music_selection_dialog/music_selection_dialog.dart';
import 'package:random_alarm/components/music_selection_dialog/playlist_selection_dialog.dart';
import 'package:random_alarm/screens/edit_alarm/components/music_list_item.dart';
import 'package:random_alarm/screens/edit_alarm/components/playlist_list_item.dart';
import 'package:random_alarm/stores/observable_alarm/observable_alarm.dart';

enum SelectionMode { SINGLE, PLAYLIST }

class EditAlarmMusic extends StatelessWidget {
  final ObservableAlarm alarm;

  const EditAlarmMusic({Key key, this.alarm}) : super(key: key);

  void openSingleSelectionDialog(context) async {
    final audioQuery = FlutterAudioQuery();
    final songs =
        await audioQuery.getSongs(sortType: SongSortType.DISPLAY_NAME);

    showDialog(
        context: context,
        builder: (context) =>
            MusicSelectionDialog(alarm: alarm, titles: songs));
  }

  void openPlaylistSelectionDialog(context) async {
    final audioQuery = FlutterAudioQuery();
    final playlists = await audioQuery.getPlaylists();

    showDialog(
      context: context,
      builder: (context) =>
          PlaylistSelectionDialog(alarm: alarm, playlists: playlists),
    );
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
            PopupMenuButton<SelectionMode>(
              icon: Icon(
                Icons.add,
                color: Colors.deepPurple,
              ),
              itemBuilder: (_) {
                return [
                  {"text": "Single selection", "value": SelectionMode.SINGLE},
                  {"text": "Playlist", "value": SelectionMode.PLAYLIST},
                ]
                    .map((item) => PopupMenuItem<SelectionMode>(
                        value: item["value"], child: Text(item["text"])))
                    .toList();
              },
              onSelected: (selection) {
                switch (selection) {
                  case SelectionMode.SINGLE:
                    openSingleSelectionDialog(context);
                    break;
                  case SelectionMode.PLAYLIST:
                    openPlaylistSelectionDialog(context);
                    break;
                }
              },
            )
          ],
        ),
        SizedBox.fromSize(
          size: Size.fromHeight(300),
          child: Observer(
            builder: (context) {
              final musicListItems = alarm.trackInfo
                  .map((info) => MusicListItem(
                        alarm: alarm,
                        musicInfo: info,
                        key: Key(info.id),
                      ))
                  .toList();

              final playlistListItems =
                  alarm.playlistInfo.map((info) => PlaylistListItem(
                        alarm: alarm,
                        playlistInfo: info,
                        key: Key(info.id),
                      ));

              return ReorderableListView(
                children: [...musicListItems, ...playlistListItems],
                onReorder: this.alarm.reorder,
              );
            },
          ),
        ),
      ],
    );
  }
}
