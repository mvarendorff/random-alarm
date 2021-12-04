typedef StringMapping<T> = String Function(T a);
typedef Filter<T> = bool Function(T a, String search);

/// Store that holds a Map tracking which songs are selected.
class SearchableSelectionStore<T> {
  final List<T> availableItems;

  final StringMapping<T> valueMapping;
  final Filter<T> filter;

  SearchableSelectionStore(
    this.availableItems,
    List<String> selectedItems,
    this.valueMapping,
    this.filter,
  ) {
    final selectableItems = availableItems.map(valueMapping).toList();
    itemSelected = {};
    selectableItems.forEach((id) {
      final selected = selectedItems.contains(id);
      itemSelected[id] = selected;
    });
  }

  Map<String, bool> itemSelected = {};

  String currentSearch = "";

  List<String> get filteredIds {
    return availableItems
        .where((item) => filter(item, currentSearch))
        .map(valueMapping)
        .toList();
  }

  clearSearch() {
    currentSearch = "";
  }
}
