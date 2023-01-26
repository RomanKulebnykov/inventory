part of 'firestore_inventory_manager.dart';

extension FirestoreInventoryManagerHelpers on FirestoreInventoryManager {
  /// ---------------------------------------------------------------getOrderSum

  /// ---------------------------------------------------------_addIfNotContains
  List<T> _addIfNotContains<T>(List<T> list, T value) =>
      list.contains(value) ? [...list] : [...list, value];

  /// --------------------------------------------------------updatePrepareItems
  List<ItemPrepare> updatePrepareItems(
    List<ItemPrepare> prepareItems, {
    required List<ItemBalance> dependsProductItems,
  }) {
    final updPendingItems = <ItemPrepare>[];
    for (final itemPrep in prepareItems) {
      var updItemPrep = itemPrep;
      if (itemPrep.isDone == false) {
        final actItem = dependsProductItems.firstWhereOrNull(
          (itemProd) => itemProd.id == itemPrep.id,
        );
        if (actItem != null) {
          updItemPrep = itemPrep.updateDepends(itemAction: actItem);
        }
      }
      updPendingItems.add(updItemPrep);
    }
    return updPendingItems;
  }
}
