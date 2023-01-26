import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:inventory_manager/inventory_manager.dart';
import 'package:test/test.dart';

import '../../../../test_helper.dart';

Future<void> main() async {
  final enterOrder = RandomItems.getRandomEnterOrder([
    RandomItems.getRandomOrderItem,
    RandomItems.getRandomOrderItem,
  ]);

  final lossOrder = RandomItems.getRandomLossOrder([
    RandomItems.getRandomOrderItem,
    RandomItems.getRandomOrderItem,
  ]);

  late FakeFirebaseFirestore firestore;
  late ProductOrdersRepository repository;

  TestHelper testHelper;
  setUp(
    () async => {
      testHelper = TestHelper(),
      repository = testHelper.productOrdersRepository,
      firestore = testHelper.fakeFirestore,
    },
  );

  group('ProductOrderRepository saveProductOrder', () {
    test('saveProductOrder EnterOrder', () async {
      expect(firestore.dump(), '{}');
      await repository.saveProductOrder<OrderInventoryEnter>(
          newOrder: enterOrder);
      expect(firestore.dump(), isNot('{}'));
    });
    test('saveProductOrder LossOrder', () async {
      expect(firestore.dump(), '{}');
      await repository.saveProductOrder<OrderInventoryLoss>(
          newOrder: lossOrder);
      expect(firestore.dump(), isNot('{}'));
    });
    test('saveProductOrder EnterOrder with transaction', () async {
      expect(firestore.dump(), '{}');
      await firestore.runTransaction((transaction) async {
        await repository.saveProductOrder<OrderInventoryEnter>(
          newOrder: enterOrder,
          transaction: transaction,
        );
      });
      expect(firestore.dump(), isNot('{}'));
    });
    test('saveProductOrder LossOrder with transaction', () async {
      expect(firestore.dump(), '{}');
      await firestore.runTransaction((transaction) async {
        await repository.saveProductOrder<OrderInventoryLoss>(
          newOrder: lossOrder,
          transaction: transaction,
        );
      });
      expect(firestore.dump(), isNot('{}'));
    });
  });
}
