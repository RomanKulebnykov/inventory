import 'package:flutter/material.dart';

import 'screens/enter_orders_screen.dart';
import 'screens/loss_orders_screen.dart';

class InventoryOrdersScreen extends StatefulWidget {
  const InventoryOrdersScreen({Key? key}) : super(key: key);

  @override
  State<InventoryOrdersScreen> createState() => _InventoryOrdersScreenState();
}

class _InventoryOrdersScreenState extends State<InventoryOrdersScreen> {
  @override
  void initState() {
    screen = screens.first;
    super.initState();
  }

  final screens = [
    const EnterOrdersScreen(),
    const LossOrdersScreen(),
  ];
  late Widget screen;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: screen),

        /// Controls Section
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () => setState(() {
                  screen = const EnterOrdersScreen();
                }),
                child: const Text('Enter Order'),
              ),
              const SizedBox(width: 4),
              ElevatedButton(
                onPressed: () => setState(() {
                  screen = const LossOrdersScreen();
                }),
                child: const Text('Loss Order'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
