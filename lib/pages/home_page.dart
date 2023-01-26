import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/navigation_controller.dart';
import '../utils/device.dart';
import '../utils/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Device.of(context).deviceType == DeviceType.phone) {
      return const _HomePageSmall();
    } else {
      return const _HomePageLarge();
    }
  }
}

class _HomePageLarge extends StatelessWidget {
  const _HomePageLarge({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationController>(
      builder: (context, navC, child) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            elevation: 5,
            currentIndex: navC.screenIndex,
            onTap: navC.setScreen,
            items: [
              for (final screen in navC.screenInCurrentGroup)
                BottomNavigationBarItem(
                  icon: screen.icon,
                  label: screen.title,
                )
            ],
          ),
          body: Row(
            children: [
              NavigationRail(
                selectedIndex: navC.screenGroupIndex,
                onDestinationSelected: navC.setScreenGroup,
                labelType: NavigationRailLabelType.all,
                useIndicator: true,
                indicatorColor: Colors.blueGrey.withAlpha(20),
                elevation: 5,
                selectedIconTheme: IconThemeData(
                  color: AppTheme.navigationRailColor,
                ),
                selectedLabelTextStyle: TextStyle(
                  color: AppTheme.navigationRailColor,
                ),
                // extended: true,
                destinations: [
                  for (final screenGroup in navC.screensGroup)
                    NavigationRailDestination(
                      icon: screenGroup.icon,
                      selectedIcon: screenGroup.selectedIcon,
                      label: Text(screenGroup.title),
                    ),
                ],
              ),
              Expanded(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 500),
                  child: navC.currentScreen.screen,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _HomePageSmall extends StatelessWidget {
  const _HomePageSmall({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(),
      body: Text('widget.screens[_currentScreen].screen'),
    );
  }
}
