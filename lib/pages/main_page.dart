//
// import 'package:example/pages/models/bottom_navigation_screen.dart';
// import 'package:flutter/material.dart';
//
// import 'screens/inventory_orders_screen/inventory_orders_screen.dart';
//
//
// class MainPage extends StatefulWidget {
//   const MainPage({Key? key}) : super(key: key);
//
//   @override
//   State<MainPage> createState() => _MainPageState();
// }
//
// class _MainPageState extends State<MainPage> {
//   int currentScreen = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(screens[currentScreen].title),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//       ),
//       body: screens[currentScreen].screen,
//       floatingActionButton: screens[currentScreen].floatingActions,
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: currentScreen,
//         onTap: (index) => setState(() => currentScreen = index),
//         items: [
//           for (final screen in screens)
//             BottomNavigationBarItem(
//               icon: screen.icon,
//               label: screen.title,
//             ),
//         ],
//       ),
//     );
//   }
//
//   /// Get Screens
//   List<BottomNavigationScreen> get screens => [
//         BottomNavigationScreen(
//           icon: const Icon(Icons.shopping_cart_rounded),
//           title: 'Products',
//           floatingActions: [
//             ElevatedButton(
//               onPressed: () {
//                 showModalBottomSheet(
//                   context: context,
//                   builder: (context) => const SizedBox(
//                     child: AddProductDialog(),
//                   ),
//                 );
//               },
//               child: const Text('Add Product'),
//             ),
//           ],
//           screen: const ProductList(),
//         ),
//         const BottomNavigationScreen(
//           icon: Icon(Icons.document_scanner),
//           title: 'Inventory',
//           screen: InventoryOrdersScreen(),
//         ),
//       ];
//
//   /// Get Floating Action Button
//   // Widget _floatingButton(BuildContext context) {
//   //   return ElevatedButton(
//   //     onPressed: () => screens[currentScreen].onFloatingTap(context),
//   //     child: Text(screens[currentScreen].floatingText),
//   //   );
//   // }
// }
