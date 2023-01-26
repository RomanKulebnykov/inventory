import '../../models/orders/orders.dart';

class ConverterOrderItem {
  ConverterOrderItem._internal();
  static Map<String, dynamic> toFirestore(ItemBalance item) {
    return {
      'id': item.id,
      'count': item.count,
      'price': item.price,
    };
  }

  static ItemBalance fromFirestore(Map<String, dynamic> snapshot) {
    return ItemBalance(
      id: snapshot['id'],
      count: int.parse(snapshot['count'].toString()),
      price: double.parse(snapshot['price'].toString()),
    );
  }
}
