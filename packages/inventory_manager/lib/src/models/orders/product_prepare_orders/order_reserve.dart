import '../orders.dart';

class OrderReserve extends OrderProductPrepare {
  final List<String> outcomeOrdersLinks;
  final String organizationAccountId;
  final String customerAccountId;

  OrderReserve({
    super.id,
    super.isActive,
    super.status,
    super.dateTime,
    super.description,
    super.items,
    required this.organizationAccountId,
    required this.customerAccountId,
    List<String>? outcomeOrdersLinks,
  }) : outcomeOrdersLinks = outcomeOrdersLinks ?? [];
}
