import '../orders.dart';

class OrderOutcome extends OrderProductBalance {
  final String? reserveOrderLink;
  final String organizationAccountId;
  final String customerAccountId;

  OrderOutcome({
    super.id,
    super.isActive,
    super.status,
    super.dateTime,
    super.description,
    super.items,
    this.reserveOrderLink,
    required this.organizationAccountId,
    required this.customerAccountId,
  });
}
