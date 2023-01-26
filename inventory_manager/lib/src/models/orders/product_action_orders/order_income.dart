import '../orders.dart';

class OrderIncome extends OrderProductBalance {
  final String? pendingOrderLink;
  final String organizationAccountId;
  final String counterpartyAccountId;

  OrderIncome({
    super.id,
    super.isActive,
    super.status,
    super.dateTime,
    super.description,
    super.items,
    this.pendingOrderLink,
    required this.organizationAccountId,
    required this.counterpartyAccountId,
  });
}
