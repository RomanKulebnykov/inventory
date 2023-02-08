import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:inventory_manager/inventory_manager.dart';
import 'package:test/test.dart';

import '../../../test_helper.dart';

void main() {
  late final FakeFirebaseFirestore firestore;
  late final FirestoreInventoryManager inventoryManager;

  /// OrderItem
  ItemBalance orderItem1 = RandomItems.getRandomOrderItem;
  ItemBalance orderItem2 = RandomItems.getRandomOrderItem;

  setUp(() async {
    TestHelper testHelper = TestHelper();
    firestore = testHelper.fakeFirestore;
    inventoryManager = testHelper.firestoreInventoryManager;
  });

  group('helpers', () {
    test('updatePrepareItems', () {
      const prodId1 = 'id1';
      const prodId2 = 'id2';
      const prodId3 = 'id3';
      const prodId4 = 'id4';
      const prodId5 = 'id5';
      final prepItems = [
        ItemPrepare(id: prodId1, expect: 5, actually: 3, price: 600),
        ItemPrepare(id: prodId2, expect: 3, actually: 3, price: 800),
        ItemPrepare(id: prodId3, expect: 10, actually: 2, price: 1000),
        ItemPrepare(id: prodId4, expect: 4, actually: 0, price: 300),
      ];
      final prodItems = [
        ItemBalance(id: prodId1, price: 600, count: 3),
        ItemBalance(id: prodId2, price: 800, count: 3),
        ItemBalance(id: prodId3, price: 1000, count: 3),
        ItemBalance(id: prodId5, price: 300, count: 3),
      ];
      final res = inventoryManager.updatePrepareItems(
        prepItems,
        dependsProductItems: prodItems,
      );
      final expected = [
        ItemPrepare(id: prodId1, expect: 5, actually: 5, price: 600),
        ItemPrepare(id: prodId2, expect: 3, actually: 3, price: 800),
        ItemPrepare(id: prodId3, expect: 10, actually: 5, price: 1000),
        ItemPrepare(id: prodId4, expect: 4, actually: 0, price: 300),
      ];
      expect(res, expected);
    });
  });
}
