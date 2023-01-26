import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

import 'package:inventory_manager/inventory_manager.dart';
import 'package:test/test.dart';

import 'package:uuid/uuid.dart';

void main() {
  final order = OrderInventoryLoss(
    id: const Uuid().v4(),
    status: OrderStatus.newOrder,
    dateTime: DateTime.now(),
    items: [
      ItemBalance(id: const Uuid().v4(), price: 600.0, count: 5),
      ItemBalance(id: const Uuid().v4(), price: 800.0, count: 2),
    ],
    description: 'Hello world',
  );

  group('ConverterEnterOrder', () {
    test('Should correct convert to firestore', () async {
      final fakeFirestore = FakeFirebaseFirestore();
      await fakeFirestore
          .collection('test')
          .doc(order.id)
          .set(ConverterLossOrder.toFirestore(order));
      expect(fakeFirestore.dump(), isNot('{}'));
    });
    test('Should correct convert from firestore', () async {
      final fakeFirestore = FakeFirebaseFirestore();

      await fakeFirestore
          .collection('test')
          .doc(order.id)
          .set(ConverterLossOrder.toFirestore(order));
      final snap = await fakeFirestore.collection('test').doc(order.id).get();
      final result = ConverterLossOrder.fromFirestore(snap.data()!);
      expect(result, order);
    });
  });
}
