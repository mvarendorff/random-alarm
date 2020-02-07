import 'package:mobx/mobx.dart';

part 'music_selection.g.dart';

class MusicSelectionStore = _MusicSelectionStore with _$MusicSelectionStore;

/// Store that holds a Map tracking which songs are selected.
abstract class _MusicSelectionStore with Store {

  _MusicSelectionStore(List<String> selectableTitles,
      List<String> selectedTitles) {
    trackSelected = ObservableMap();
    selectableTitles.forEach((id) {
      final selected = selectedTitles.contains(id);
      trackSelected[id] = selected;
    });
  }

  @observable
  ObservableMap<String, bool> trackSelected = ObservableMap();

}
