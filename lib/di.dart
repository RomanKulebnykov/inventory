import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:inventory_manager/inventory_manager.dart';
import 'package:products_catalog/products_catalog.dart';
import 'package:shared_kernel/shared_kernel.dart';

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

    ///#########################################################################
    /// Products Catalog ///////////////////////////////////////////////////////
    ///#########################################################################
    final brandLocal = BrandDataSourceMemoryCache();
    final brandRemote = BrandDataSourceFirestore(
      getStorageFilesPath: () => fbStorage.ref('username'),
      getBrendsCollectionPath: () => firestore
          .collection('username')
          .doc('productsCatalog')
          .collection('brends'),
    );

    final brandRepository = BrandsRepository(
      policies: FetchPolicies.remoteOnly,
      local: brandLocal,
      remote: brandRemote,
    );

    getIt.registerLazySingleton<BrandsRepository>(() => brandRepository);

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
