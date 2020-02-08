import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:random_alarm/stores/music_selection/music_selection.dart';
import 'package:random_alarm/stores/observable_alarm/observable_alarm.dart';

class MusicSelectionDialog extends StatelessWidget {
  final List<SongInfo> titles;
  final ObservableAlarm alarm;

  final MusicSelectionStore store;

  MusicSelectionDialog({Key key, this.titles, this.alarm})
      : store = MusicSelectionStore(titles.map((info) => info.id).toList(),
            alarm.trackInfo.map((info) => info.id).toList()),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(child: TextField(controller: controller)),
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () => controller.clear(),
                )
              ],
            ),
            MusicList(titles: titles, store: store),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                  child: Text('Cancel'),
                  onPressed: () => Navigator.pop(context),
                ),
                FlatButton(
                  child: Text('Done'),
                  onPressed: () {
                    final newSelected = store.trackSelected.entries
                        .where((entry) => entry.value)
                        .map((entry) => entry.key);
                    alarm.musicPaths = ObservableList.of(newSelected);
                    alarm.loadTracks();
                    return Navigator.pop(context);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MusicList extends StatelessWidget {
  final List<SongInfo> titles;
  final MusicSelectionStore store;

  const MusicList({Key key, this.titles, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size.fromHeight(400),
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final title = titles[index];

          return Observer(
              builder: (context) => CheckboxListTile(
                    value: store.trackSelected[title.id] ?? false,
                    title: Text(title.title ?? title.displayName),
                    onChanged: (newValue) {
                      return store.trackSelected[title.id] = newValue;
                    },
                  ));
        },
        itemCount: titles.length,
      ),
    );
  }
}
