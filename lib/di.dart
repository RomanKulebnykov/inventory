import 'package:data_storage_local/data_storage_local.dart';
import 'package:data_storage_remote/data_storage_remote.dart';
import 'package:data_storage_repository/data_storage_repository.dart';
import 'package:domain_models/domain_models.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:inventory_manager/inventory_manager.dart';
import 'package:products_manager/products_manager.dart';

import 'firebase_options.dart';

class Di {
  Di._internal();
  static GetIt getIt = GetIt.instance;
  static Future<void> setup() async {
    ///#########################################################################
    /// Firebase ///////////////////////////////////////////////////////////////
    ///#########################################################################
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final firestore = FirebaseFirestore.instance;
    final fbStorage = FirebaseStorage.instance;
    if (true) {
      firestore.useFirestoreEmulator('localhost', 8080);
      firestore.settings = const Settings(persistenceEnabled: false);
      await fbStorage.useStorageEmulator('localhost', 9199);
    }

    getIt.registerLazySingleton(() => firestore);
    getIt.registerLazySingleton(() => fbStorage);

    ///#########################################################################
    /// Storage ////////////////////////////////////////////////////////////////
    ///#########################################################################
    final storageRepository = DataStorageRepository(
      basePath: 'username',
      local: DataStorageLocal(),
      remote: DataStorageRemote(getIt()),
    );

    getIt.registerLazySingleton(() => storageRepository);

    ///#########################################################################
    /// Products Manager ///////////////////////////////////////////////////////
    ///#########################################################################

    /// -------------------------------------------------------- ProductsManager
    getIt.registerLazySingleton<ProductsManager>(
      () => FirestoreProductManager(
        getBrendsCollectionPath: () {
          return firestore.collection('brends');
        },
        getProductCollectionPath: <T extends IProduct>() {
          return firestore.collection('Products');
        },
      ),
    );

    ///#########################################################################
    /// Inventory Manager //////////////////////////////////////////////////////
    ///#########################################################################

    /// ----------------------------------------------- ProductBalanceRepository
    getIt.registerLazySingleton<ProductBalanceRepositoryImpl>(
      () => ProductBalanceRepositoryImpl(
        getBalanceCollectionPath: () {
          return firestore.collection('productBalances');
        },
      ),
    );

    /// --------------------------------------------- MoneyBalanceRepositoryImpl
    getIt.registerLazySingleton<MoneyBalanceRepositoryImpl>(
      () => MoneyBalanceRepositoryImpl(
        getBalanceCollectionPath: () {
          return firestore.collection('moneyBalances');
        },
      ),
    );

    /// -------------------------------------------------- MoneyOrdersRepository
    getIt.registerLazySingleton<MoneyOrdersRepositoryImpl>(
      () => MoneyOrdersRepositoryImpl(
        getMoneyOrderCollectionPath: <T extends OrderMoney>() {
          return firestore
              .collection('moneyOrders')
              .doc('${T.toString()}s')
              .collection('ordersData');
        },
      ),
    );

    /// ------------------------------------------------ ProductOrdersRepository
    getIt.registerLazySingleton<ProductOrdersRepositoryImpl>(
      () => ProductOrdersRepositoryImpl(
        getProductOrderCollectionPath: <T extends OrderProduct>() {
          return firestore
              .collection('productOrders')
              .doc('${T.toString()}s')
              .collection('ordersData');
        },
      ),
    );

    /// ------------------------------------------------------- InventoryManager
    getIt.registerLazySingleton<InventoryManager>(
      () => FirestoreInventoryManager(
        firestore: getIt(),
        productBalanceRepository: getIt(),
        moneyBalanceRepository: getIt(),
        moneyOrdersRepository: getIt(),
        productOrderRepository: getIt(),
      ),
    );
  }
}
