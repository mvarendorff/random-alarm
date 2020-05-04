import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:mobx/mobx.dart';

part 'searchable_selection.g.dart';

class SearchableSelectionStore<T> = _SearchableSelectionStore<T> with _$SearchableSelectionStore<T>;

typedef StringMapping<T> = String Function(T a);
typedef Filter<T> = bool Function(T a, String search);

/// Store that holds a Map tracking which songs are selected.
abstract class _SearchableSelectionStore<T> with Store {
  final List<T> availableItems;

  final StringMapping<T> valueMapping;
  final Filter<T> filter;

  _SearchableSelectionStore(this.availableItems, List<String> selectedItems, this.valueMapping, this.filter,) {
    final selectableItems = availableItems.map(valueMapping).toList();
    itemSelected = ObservableMap();
    selectableItems.forEach((id) {
      final selected = selectedItems.contains(id);
      itemSelected[id] = selected;
    });
  }

  @observable
  ObservableMap<String, bool> itemSelected = ObservableMap();

  @observable
  String currentSearch = "";

  @computed
  List<String> get filteredIds {
    return availableItems.where((item) => filter(item, currentSearch))
        .map(valueMapping)
        .toList();
  }

  @action
  clearSearch() {
    currentSearch = "";
  }
}
