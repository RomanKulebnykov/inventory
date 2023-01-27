import 'i_order_basic.dart';

abstract class OrderMoney extends OrderBasic {
  OrderMoney({
    super.id,
    super.dateTime,
    super.status,
  });
}
