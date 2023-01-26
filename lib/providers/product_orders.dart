import 'package:flutter/material.dart';
import 'package:inventory_manager/inventory_manager.dart';

import 'package:provider/provider.dart';

class ProductOrders<T extends OrderProduct> extends ChangeNotifier {
  factory ProductOrders.read(BuildContext context) =>
      context.read<ProductOrders<T>>();

  factory ProductOrders.watch(BuildContext context) =>
      context.watch<ProductOrders<T>>();

  ProductOrders(this._inventoryManager) {
    _inventoryManager.getProductOrders<T>().then((value) {
      _orders = value ?? [];
      notifyListeners();
    });
  }

  final InventoryManager _inventoryManager;

  List<T> _orders = [];
  List<T> get orders => [..._orders];

  int get count => _orders.length;

  Future<void> _updateOrderList() async {
    _orders = await _inventoryManager.getProductOrders<T>() ?? [];
    notifyListeners();
  }

  Future<void> addOrder({
    required T newOrder,
  }) async {
    await _inventoryManager.saveProductOrder<T>(newOrder: newOrder);
    _updateOrderList();
  }
}
