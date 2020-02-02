import 'package:flutter/material.dart';
import 'package:random_alarm/stores/observable_alarm/observable_alarm.dart';

class MusicSelectionDialog extends StatelessWidget {
  final List<String> titles;
  final ObservableAlarm alarm;

  const MusicSelectionDialog({Key key, this.titles, this.alarm}) : super(key: key);

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
            MusicList(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                  child: Text('Cancel'),
                  onPressed: () =>
                      Navigator.pop(context), //TODO discard changes
                ),
                FlatButton(
                  child: Text('Done'),
                  onPressed: () => Navigator.pop(context),
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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) =>
          SelectableItem(
            isSelected: false,
            songName: titles[index],
          ),
      itemCount: titles.length,
    );
  }

}

class SelectableItem extends StatelessWidget {
  final bool isSelected;
  final String songName;

  const SelectableItem({Key key, this.isSelected, this.songName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Checkbox(
            value: isSelected,
            onChanged: (value) {
              print('Yeet');
            }),
        Expanded(child: Text(songName)),
      ],
    );
  }
}
