import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory/blocs/navigation/navigation_bloc.dart';
import 'package:inventory/blocs/products/products_bloc.dart';
import 'package:inventory/utils/device.dart';
import 'package:inventory/utils/theme.dart';
import 'package:inventory_manager/inventory_manager.dart';

import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'di.dart';
import 'pages/home_page.dart';
import 'providers/navigation_controller.dart';
import 'providers/product_orders_provider.dart';
import 'providers/products_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();
  windowManager.setSize(const Size(800, 640));
  windowManager.setMinimumSize(const Size(800, 640));

  await Di.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme(Device.of(context).deviceType);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavigationBloc()),
        BlocProvider(create: (context) => ProductsBloc(Di.getIt())),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<ProductsProvider>(
            create: (context) => ProductsProvider(Di.getIt()),
          ),
          ChangeNotifierProvider<ProductOrdersProvider<OrderInventoryEnter>>(
            create: (context) => ProductOrdersProvider(Di.getIt()),
          ),
          ChangeNotifierProvider<ProductOrdersProvider<OrderInventoryLoss>>(
            create: (context) => ProductOrdersProvider(Di.getIt()),
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
      ),
    );
  }
}
