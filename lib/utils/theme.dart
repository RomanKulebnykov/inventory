import 'package:flutter/material.dart';

import 'device.dart';

class AppTheme {
  AppTheme(this.deviceType);

  final DeviceType deviceType;

  double get scaleFactor => deviceType == DeviceType.desktop ? 0.7 : 1.0;

  IconThemeData get iconTheme => deviceType == DeviceType.desktop
      ? const IconThemeData(size: 20)
      : const IconThemeData();

  InputDecorationTheme get inputDecorationTheme =>
      (deviceType == DeviceType.desktop)
          ? const InputDecorationTheme(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 12,
              ),
            )
          : const InputDecorationTheme();

  static Color get navigationRailColor => Colors.blue;
  static Color get heightLightListColor => Colors.blue;
  static Color get addElementColor => Colors.green;

  ThemeData get getTheme => ThemeData.dark().copyWith(
        // primaryColor: Colors.orange,
        colorScheme: ThemeData.dark().colorScheme.copyWith(
              primary: Colors.blueGrey,
            ),
        // useMaterial3: true,
        // primarySwatch: Colors.orange,
        inputDecorationTheme: inputDecorationTheme,
        iconTheme: iconTheme,
      );
}
