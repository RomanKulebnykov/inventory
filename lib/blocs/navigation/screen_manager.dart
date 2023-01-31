import 'package:flutter/material.dart';

import '../../pages/screens/products_screen/products_screen.dart';

class ScreenManager {
  static List<ScreenGroup> screensGroups() => _screensGroups;

  static List<Screen> screens({required int group}) =>
      _screensGroups[group].screens;

  static Screen screenInCurrentGroup(
          {required int group, required int screen}) =>
      _screensGroups[group].screens[screen];

  static const List<ScreenGroup> _screensGroups = [
    /// Products , Customers, Counterparty, Product Balances,
    ScreenGroup(
      icon: Icon(Icons.sell_outlined),
      selectedIcon: Icon(Icons.sell),
      title: 'Instances',
      screens: [
        Screen(
          icon: Icon(Icons.fireplace),
          selectedIcon: Icon(Icons.fireplace),
          title: 'Products',
          screen: ProductsScreen(),
        ),
        Screen(
          icon: Icon(Icons.fireplace),
          selectedIcon: Icon(Icons.fireplace),
          title: 'title',
          screen: Placeholder(),
        ),
      ],
    ),

    /// Inventory Orders, Enter Orders, Loss Orders
    ScreenGroup(
      icon: Icon(Icons.inventory_2_outlined),
      selectedIcon: Icon(Icons.inventory),
      title: 'Inventory',
      screens: [
        Screen(
          icon: Icon(Icons.fireplace),
          selectedIcon: Icon(Icons.fireplace),
          title: 'title',
          screen: Placeholder(),
        ),
        Screen(
          icon: Icon(Icons.fireplace),
          selectedIcon: Icon(Icons.fireplace),
          title: 'title',
          screen: Placeholder(),
        ),
      ],
    ),

    /// Pending Orders, Income Orders, Return Income Orders
    ScreenGroup(
      icon: Icon(Icons.add_box_outlined),
      selectedIcon: Icon(Icons.add_box),
      title: 'Income',
      screens: [
        Screen(
          icon: Icon(Icons.fireplace),
          selectedIcon: Icon(Icons.fireplace),
          title: 'title',
          screen: Placeholder(),
        ),
        Screen(
          icon: Icon(Icons.fireplace),
          selectedIcon: Icon(Icons.fireplace),
          title: 'title',
          screen: Placeholder(),
        ),
      ],
    ),

    /// Reserve Orders, Outcome Orders, Return Outcome Orders
    ScreenGroup(
      icon: Icon(Icons.indeterminate_check_box_outlined),
      selectedIcon: Icon(Icons.indeterminate_check_box),
      title: 'Outcome',
      screens: [
        Screen(
          icon: Icon(Icons.fireplace),
          selectedIcon: Icon(Icons.fireplace),
          title: 'title',
          screen: Placeholder(),
        ),
        Screen(
          icon: Icon(Icons.fireplace),
          selectedIcon: Icon(Icons.fireplace),
          title: 'title',
          screen: Placeholder(),
        ),
      ],
    ),

    /// Income Money, Outcome Money, Transfer Money, Money Balances
    ScreenGroup(
      icon: Icon(Icons.monetization_on_outlined),
      selectedIcon: Icon(Icons.monetization_on),
      title: 'Money',
      screens: [
        Screen(
          icon: Icon(Icons.fireplace),
          selectedIcon: Icon(Icons.fireplace),
          title: 'title',
          screen: Placeholder(),
        ),
        Screen(
          icon: Icon(Icons.fireplace),
          selectedIcon: Icon(Icons.fireplace),
          title: 'title',
          screen: Placeholder(),
        ),
      ],
    ),

    /// Product Balances, Profit and loss, Mutual settlements
    ScreenGroup(
      icon: Icon(Icons.area_chart_outlined),
      selectedIcon: Icon(Icons.area_chart),
      title: 'Stats',
      screens: [
        Screen(
          icon: Icon(Icons.fireplace),
          selectedIcon: Icon(Icons.fireplace),
          title: 'title',
          screen: Placeholder(),
        ),
        Screen(
          icon: Icon(Icons.fireplace),
          selectedIcon: Icon(Icons.fireplace),
          title: 'title',
          screen: Placeholder(),
        ),
      ],
    ),

    /// Settings
    ScreenGroup(
      icon: Icon(Icons.settings_outlined),
      selectedIcon: Icon(Icons.settings),
      title: 'Settings',
      screens: [
        Screen(
          icon: Icon(Icons.fireplace),
          selectedIcon: Icon(Icons.fireplace),
          title: 'title',
          screen: Placeholder(),
        ),
        Screen(
          icon: Icon(Icons.fireplace),
          selectedIcon: Icon(Icons.fireplace),
          title: 'title',
          screen: Placeholder(),
        ),
      ],
    ),
  ];
}

class ScreenGroup {
  final Icon icon;
  final Icon selectedIcon;
  final String title;
  final List<Screen> screens;

  const ScreenGroup({
    required this.icon,
    required this.selectedIcon,
    required this.title,
    required this.screens,
  });
}

class Screen {
  final Icon icon;
  final Icon selectedIcon;
  final String title;
  final Widget screen;

  const Screen({
    required this.icon,
    required this.selectedIcon,
    required this.title,
    required this.screen,
  });
}
