import 'package:flutter/material.dart';
import 'package:inventory/utils/device.dart';
import 'package:inventory/utils/theme.dart';
import 'package:inventory_manager/inventory_manager.dart';

import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'di.dart';
import 'pages/home_page.dart';
import 'providers/navigation_controller.dart';
import 'providers/product_orders.dart';
import 'providers/products.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await windowManager.ensureInitialized();
  // windowManager.setMinimumSize(const Size(800, 640));
  // windowManager.setSize(const Size(800, 640));

  await Di.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme(Device.of(context).deviceType);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Products>(
          create: (context) => Products(Di.getIt()),
        ),
        ChangeNotifierProvider<NavigationController>(
          create: (context) => NavigationController(),
        ),
        ChangeNotifierProvider<ProductOrders<OrderInventoryEnter>>(
          create: (context) => ProductOrders(Di.getIt()),
        ),
        ChangeNotifierProvider<ProductOrders<OrderInventoryLoss>>(
          create: (context) => ProductOrders(Di.getIt()),
        ),
      ],
      child: MaterialApp(
        title: 'Inventory Manager Demo',
        theme: appTheme.getTheme,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: appTheme.scaleFactor,
            ),
            child: child!,
          );
        },
        home: const HomePage(),
      ),
    );
  }
}
