import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

/// OrderStatus
enum OrderStatus {
  newOrder;

  static OrderStatus fromString(String name) {
    return OrderStatus.values.firstWhere((element) {
      return element.name.toLowerCase() == name.toLowerCase();
    });
  }
}

abstract class OrderBasic extends Equatable {
  final String id;
  final bool isActive;
  final OrderStatus status;
  final DateTime dateTime;
  final String description;

  OrderBasic({
    String? id,
    OrderStatus? status,
    DateTime? dateTime,
    this.isActive = true,
    this.description = '',
  })  : dateTime = dateTime ?? DateTime.now().toUtc(),
        id = id ?? const Uuid().v4(),
        status = status ?? OrderStatus.newOrder;

  @override
  List<Object?> get props => [id, status, dateTime, isActive, description];

  @override
  String toString() {
    return '$runtimeType{id: $id, status: $status, dateTime: $dateTime, isActive: $isActive}';
  }
}
