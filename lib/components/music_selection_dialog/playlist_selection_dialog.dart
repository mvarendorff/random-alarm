import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:random_alarm/components/music_selection_dialog/dialog_base.dart';
import 'package:random_alarm/stores/music_selection/searchable_selection.dart';
import 'package:random_alarm/stores/observable_alarm/observable_alarm.dart';

class PlaylistSelectionDialog extends StatelessWidget {
  final ObservableAlarm alarm;
  final List<PlaylistInfo> playlists;

  final SearchableSelectionStore<PlaylistInfo> store;

  PlaylistSelectionDialog({Key key, this.alarm, this.playlists})
      : store = SearchableSelectionStore(
            playlists,
            alarm.playlistInfo.map((info) => info.id).toList(),
            (info) => info.id,
            (info, search) {
              final filter = RegExp(search, caseSensitive: false);
              return info.name.contains(filter);
            }),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final onDone = () {
      final newSelected = store.itemSelected.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key);
      alarm.playlistIds = ObservableList.of(newSelected);
      alarm.loadPlaylists();
    };

    return DialogBase(
      child: PlaylistList(store: store,),
      onDone: onDone,
      onSearchClear: () => store.clearSearch(),
      onSearchChange: (newValue) => store.currentSearch = newValue,
    );
  }
}

class PlaylistList extends StatelessWidget {
  final SearchableSelectionStore<PlaylistInfo> store;

  const PlaylistList({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => ListView(
        shrinkWrap: true,
        children: store.filteredIds.map(widgetForPlaylistId).toList(),
      ),
    );
  }

  Widget widgetForPlaylistId(String id) {
    final List<PlaylistInfo> playlists = store.availableItems;
    final playlist = playlists.firstWhere((info) => info.id == id);

    return Observer(
        builder: (context) => CheckboxListTile(
              value: store.itemSelected[playlist.id] ?? false,
              title: Text(playlist.name),
              onChanged: (newValue) {
                return store.itemSelected[playlist.id] = newValue;
              },
            ));
  }
}
