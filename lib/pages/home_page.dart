import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory/blocs/navigation/navigation_bloc.dart';
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
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: Row(
            children: [
              NavigationRail(
                selectedIndex: state.groupIndex,
                onDestinationSelected: (value) {
                  NavigationBloc.addEvent(context, TapOnGroup(value));
                  // context.read<NavigationBloc>().add(TapOnGroup(value));
                },
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
                  for (final screenGroup in state.getScreensGroups)
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
                  child: state.selectedScreen.screen,
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 5,
            currentIndex: state.screenIndex,
            onTap: (value) {
              NavigationBloc.addEvent(context, TapOnScreen(value));
              // context.read<NavigationBloc>().add(TapOnScreen(value));
            },
            items: [
              for (final screen in state.screensInSelectedGroup)
                BottomNavigationBarItem(
                  icon: screen.icon,
                  label: screen.title,
                )
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
