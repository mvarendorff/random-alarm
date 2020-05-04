import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:random_alarm/components/music_selection_dialog/dialog_base.dart';
import 'package:random_alarm/stores/music_selection/music_selection.dart';
import 'package:random_alarm/stores/observable_alarm/observable_alarm.dart';

class MusicSelectionDialog extends StatelessWidget {
  final List<SongInfo> titles;
  final ObservableAlarm alarm;

  final MusicSelectionStore store;

  MusicSelectionDialog({Key key, this.titles, this.alarm})
      : store = MusicSelectionStore(titles,
      alarm.trackInfo.map((info) => info.id).toList()),
        super(key: key);


  @override
  Widget build(BuildContext context) {
    final onDone = () {
      final newSelected = store.trackSelected.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key);
      alarm.musicIds = ObservableList.of(newSelected);
      alarm.loadTracks();
    };

    return DialogBase(
      onDone: onDone,
      child: MusicList(store: store),
      onSearchChange: (newValue) => store.currentSearch = newValue,
      onSearchClear: () => store.clearSearch(),
    );
  }
}

class MusicList extends StatelessWidget {
  final MusicSelectionStore store;

  const MusicList({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) =>
          ListView(
            shrinkWrap: true,
            children: store.filteredIds.map(widgetForSongId).toList(),
          ),
    );
  }

  Widget widgetForSongId(String id) {
    final List<SongInfo> titles = store.fullSongInfo;
    final title = titles.firstWhere((info) => info.id == id);

    return Observer(
        builder: (context) =>
            CheckboxListTile(
              value: store.trackSelected[title.id] ?? false,
              title: Text(title.title ?? title.displayName),
              onChanged: (newValue) {
                return store.trackSelected[title.id] = newValue;
              },
            ));
  }

}
