import 'package:flutter/material.dart';
import 'package:inventory_manager/inventory_manager.dart';
import 'package:uuid/uuid.dart';

import '../../models/order_item.dart';

class EditOrderInventoryVM extends ChangeNotifier {
  EditOrderInventoryVM({
    required this.onOrderSave,
    required this.onEditCancelled,
    OrderInventoryEnter? editOrder,
  }) {
    if (editOrder != null) {
      id = editOrder.id;
      _orderItems = editOrder.items;
      _status = editOrder.status;
      _dateTime = editOrder.dateTime;
      isActive = editOrder.isActive;
    } else {
      id = const Uuid().v4();
      _orderItems = [];
      _status = OrderStatus.newOrder;
      _dateTime = DateTime.now();
      isActive = true;
    }
  }

  final void Function(OrderInventoryEnter order) onOrderSave;
  final void Function() onEditCancelled;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late final String id;
  late final List<ItemBalance> _orderItems;
  late OrderStatus _status;
  late DateTime _dateTime;
  late bool isActive;

  DateTime get dateTime => DateTime(
        _dateTime.year,
        _dateTime.month,
        _dateTime.day,
        _dateTime.hour,
        _dateTime.minute,
      );
  DateTime get date => DateTime(_dateTime.year, _dateTime.month, _dateTime.day);
  TimeOfDay get time => TimeOfDay.fromDateTime(_dateTime);

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

  /// ------------------------------------------------------------------ saveOrder
  void saveOrder() {
    final newOrder = OrderInventoryEnter();

    onOrderSave(newOrder);
  }

  /// ------------------------------------------------------------- editCanceled
  void editCanceled() {
    onEditCancelled();
  }

  /// ----------------------------------------------------------- Private Method
  void _showMessage(String text) {
    ScaffoldMessenger.of(scaffoldKey.currentState!.context).showSnackBar(
      SnackBar(
        content: Text(text),
        showCloseIcon: true,
        closeIconColor: Colors.red,
      ),
    );
  }
}
