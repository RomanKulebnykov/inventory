import '../orders.dart';

class OrderPending extends OrderProductPrepare {
  final List<String> incomeOrdersLinks;
  final String organizationAccountId;
  final String counterpartyAccountId;

  OrderPending({
    super.id,
    super.isActive,
    super.status,
    super.dateTime,
    super.description,
    super.items,
    required this.organizationAccountId,
    required this.counterpartyAccountId,
    List<String>? incomeOrdersLinks,
  }) : incomeOrdersLinks = incomeOrdersLinks ?? [];

  OrderPending copyWith({
    String? id,
    bool? isActive,
    OrderStatus? status,
    DateTime? dateTime,
    String? description,
    List<ItemPrepare>? items,
    List<String>? incomeOrdersLinks,
    String? organizationAccountId,
    String? counterpartyAccountId,
  }) {
    return OrderPending(
      id: id ?? this.id,
      status: status ?? this.status,
      dateTime: dateTime ?? this.dateTime,
      description: description ?? this.description,
      items: items ?? this.items,
      incomeOrdersLinks: incomeOrdersLinks ?? this.incomeOrdersLinks,
      organizationAccountId:
          organizationAccountId ?? this.organizationAccountId,
      counterpartyAccountId:
          counterpartyAccountId ?? this.counterpartyAccountId,
    );
  }
}
