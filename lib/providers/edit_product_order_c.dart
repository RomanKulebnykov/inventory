import 'package:flutter/material.dart';
import 'package:inventory_manager/inventory_manager.dart';

import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/order_item_presentation.dart';
import '../models/product.dart';

class EditProductOrderC extends ChangeNotifier {
  factory EditProductOrderC.read(BuildContext context) =>
      context.read<EditProductOrderC>();

  factory EditProductOrderC.watch(BuildContext context) =>
      context.watch<EditProductOrderC>();

  /// Constructor //////////////////////////////////////////////////////////////
  EditProductOrderC({
    OrderProductBalance? initialOrder,
    Future<List<Product>> Function(List<String> ids)? fetchProducts,
  }) {
    assert((initialOrder != null && fetchProducts != null) ||
        (initialOrder == null && fetchProducts == null));
    if (initialOrder == null) {
      id = const Uuid().v4();
      _status = OrderStatus.newOrder;
      _dateTime = DateTime.now();
    } else {
      id = initialOrder.id;
      _status = initialOrder.status;
      _dateTime = initialOrder.dateTime;
      fetchProducts!(initialOrder.items.map((e) => e.id).toList())
          .then((products) {
        _orderItems.addAll(
            products.map((e) => OrderItemPresentation.fromProductItem(e)));
        notifyListeners();
      });
    }
  }

  /// Fields ///////////////////////////////////////////////////////////////////
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final String id;
  late final List<OrderItemPresentation> _orderItems = [];
  late OrderStatus _status;
  late DateTime _dateTime;

  /// State values /////////////////////////////////////////////////////////////
  DateTime get dateTime => DateTime(
        _dateTime.year,
        _dateTime.month,
        _dateTime.day,
        _dateTime.hour,
        _dateTime.minute,
      );
  DateTime get date => DateTime(_dateTime.year, _dateTime.month, _dateTime.day);
  TimeOfDay get time => TimeOfDay.fromDateTime(_dateTime);
  List<OrderItemPresentation> get orderItems => [..._orderItems];
  OrderStatus get status => _status;

  /// Update State Methods /////////////////////////////////////////////////////
  void addOrderItem(Product product) {
    final isContains = _orderItems.map((e) => e.product).contains(product);
    if (!isContains) {
      _orderItems.add(
        OrderItemPresentation.fromProductItem(product),
      );
    }
    notifyListeners();
  }

  void updateOrderItem(OrderItemPresentation updatedItem) {
    var index = orderItems.indexWhere(
      (element) => element.id == updatedItem.id,
    );
    _orderItems[index] = updatedItem;
    notifyListeners();
  }

  void updateDate(DateTime date) {
    _dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      _dateTime.hour,
      _dateTime.minute,
    );
    notifyListeners();
  }

  void updateTime(TimeOfDay time) {
    _dateTime = DateTime(
      _dateTime.year,
      _dateTime.month,
      _dateTime.day,
      time.hour,
      time.minute,
    );
    notifyListeners();
  }
}
