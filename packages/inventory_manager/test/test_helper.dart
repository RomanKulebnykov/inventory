import 'dart:math';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:inventory_manager/inventory_manager.dart';
import 'package:uuid/uuid.dart';

class TestHelper {
  final fakeFirestore = FakeFirebaseFirestore();

  /// ProductBalanceRepository
  ProductBalanceRepositoryImpl get productBalanceRepository =>
      ProductBalanceRepositoryImpl(
        getBalanceCollectionPath: () {
          return fakeFirestore.collection('balancesProduct');
        },
      );
  MoneyBalanceRepositoryImpl get moneyBalanceRepository =>
      MoneyBalanceRepositoryImpl(
        getBalanceCollectionPath: () {
          return fakeFirestore.collection('balancesMoney');
        },
      );

  /// MoneyOrdersRepository
  MoneyOrdersRepositoryImpl get moneyOrdersRepository =>
      MoneyOrdersRepositoryImpl(
        getMoneyOrderCollectionPath: <T extends OrderMoney>() {
          return fakeFirestore
              .collection('moneyOrders')
              .doc('${T.toString()}s')
              .collection('ordersData');
        },
      );

  /// ProductOrdersRepository
  ProductOrdersRepositoryImpl get productOrdersRepository =>
      ProductOrdersRepositoryImpl(
        getProductOrderCollectionPath: <T extends OrderProduct>() {
          return fakeFirestore
              .collection('productOrders')
              .doc('${T.toString()}s')
              .collection('ordersData');
        },
      );

  /// InventoryManager
  FirestoreInventoryManager get firestoreInventoryManager =>
      FirestoreInventoryManager(
        firestore: fakeFirestore,
        moneyBalanceRepository: moneyBalanceRepository,
        productBalanceRepository: productBalanceRepository,
        moneyOrdersRepository: moneyOrdersRepository,
        productOrderRepository: productOrdersRepository,
      );
}

extension RandomItems on TestHelper {
  static final Random _random = Random();
  static double _randomCurrency(double maxDouble) {
    double ranDouble = _random.nextDouble();
    return double.parse((ranDouble * maxDouble).toStringAsFixed(2));
  }

  static ItemBalance get getRandomOrderItem => ItemBalance(
        id: const Uuid().v4(),
        price: _randomCurrency(800),
        count: _random.nextInt(5),
      );

  static OrderInventoryEnter getRandomEnterOrder(List<ItemBalance> items) =>
      OrderInventoryEnter(
        id: const Uuid().v4(),
        status: OrderStatus.newOrder,
        dateTime: DateTime.now(),
        items: items,
        description: 'Hello world',
      );

  static OrderInventoryLoss getRandomLossOrder(List<ItemBalance> items) =>
      OrderInventoryLoss(
        id: const Uuid().v4(),
        status: OrderStatus.newOrder,
        dateTime: DateTime.now(),
        items: items,
        description: 'Hello world',
      );
}
