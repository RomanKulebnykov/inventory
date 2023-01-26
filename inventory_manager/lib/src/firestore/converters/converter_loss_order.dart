import '../../models/orders/orders.dart';
import 'converter_order_item.dart';

class ConverterLossOrder {
  ConverterLossOrder._internal();
  static Map<String, dynamic> toFirestore(OrderProductBalance order) {
    return {
      'id': order.id,
      'dateTime': order.dateTime,
      'status': order.status.name,
      'description': order.description,
      'items': [
        for (final item in order.items) ConverterOrderItem.toFirestore(item)
      ],
    };
  }

  static OrderInventoryLoss fromFirestore(Map<String, dynamic> snapshot) {
    return OrderInventoryLoss(
      id: snapshot['id'],
      dateTime: snapshot['dateTime'].toDate(),
      status: OrderStatus.fromString(snapshot['status']),
      description: snapshot['description'],
      items: [
        for (final item in List.from(snapshot['items']))
          ConverterOrderItem.fromFirestore(item)
      ],
    );
  }
}
