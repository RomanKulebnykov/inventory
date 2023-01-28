import 'package:flutter/material.dart';
import 'package:inventory_manager/inventory_manager.dart';

import 'package:provider/provider.dart';

class ProductOrdersProvider<T extends OrderProduct> extends ChangeNotifier {
  factory ProductOrdersProvider.read(BuildContext context) =>
      context.read<ProductOrdersProvider<T>>();

  factory ProductOrdersProvider.watch(BuildContext context) =>
      context.watch<ProductOrdersProvider<T>>();

  ProductOrdersProvider(this._inventoryManager) {
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
