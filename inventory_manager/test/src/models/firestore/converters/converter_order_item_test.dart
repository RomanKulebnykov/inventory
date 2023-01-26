import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:inventory_manager/inventory_manager.dart';
import 'package:inventory_manager/src/firestore/converters/converter_order_item.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  final item = ItemBalance(id: const Uuid().v4(), price: 650, count: 4);
  group('ConverterOrderItem', () {
    test('Should correct convert to firestore', () async {
      final fakeFirestore = FakeFirebaseFirestore();
      await fakeFirestore
          .collection('test')
          .doc(item.id)
          .set(ConverterOrderItem.toFirestore(item));
      expect(fakeFirestore.dump(), isNot('{}'));
    });
    test('Should correct convert from firestore', () async {
      final fakeFirestore = FakeFirebaseFirestore();

      await fakeFirestore
          .collection('test')
          .doc(item.id)
          .set(ConverterOrderItem.toFirestore(item));
      final snap = await fakeFirestore.collection('test').doc(item.id).get();
      final result = ConverterOrderItem.fromFirestore(snap.data()!);
      expect(result, item);
    });
  });
}
