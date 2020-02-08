import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:mobx/mobx.dart';

part 'music_selection.g.dart';

class MusicSelectionStore = _MusicSelectionStore with _$MusicSelectionStore;

/// Store that holds a Map tracking which songs are selected.
abstract class _MusicSelectionStore with Store {
  final List<SongInfo> fullSongInfo;

  _MusicSelectionStore(this.fullSongInfo, List<String> selectedTitles,) {
    final selectableTitles = fullSongInfo.map((info) => info.id).toList();
    trackSelected = ObservableMap();
    selectableTitles.forEach((id) {
      final selected = selectedTitles.contains(id);
      trackSelected[id] = selected;
    });
  }

  @observable
  ObservableMap<String, bool> trackSelected = ObservableMap();

  @observable
  String currentSearch = "";

  @computed
  List<String> get filteredIds {
    return fullSongInfo.where((info) =>
    info.title.contains(currentSearch) ||
        info.displayName.contains(currentSearch))
        .map((info) => info.id)
        .toList();
  }

  @action
  clearSearch() {
    currentSearch = "";
  }
}
