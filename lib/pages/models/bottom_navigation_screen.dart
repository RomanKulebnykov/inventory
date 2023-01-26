import 'package:flutter/material.dart';

class BottomNavigationScreen {
  final Icon icon;
  final String title;
  final Widget screen;
  final List<Widget>? _floatingActions;
  Widget get floatingActions => _buildFloatingAction();

  const BottomNavigationScreen({
    required this.icon,
    required this.title,
    required this.screen,
    List<Widget>? floatingActions,
  }) : _floatingActions = floatingActions;

  Widget _buildFloatingAction() {
    if (_floatingActions == null) return Container();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: _floatingActions!
            .map<Widget>(
              (e) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: e,
              ),
            )
            .toList(),
      ),
    );
  }
}
