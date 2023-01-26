import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum InputType {
  touch,
  mouse;
}

enum DeviceType {
  phone,
  tablet,
  desktop,
}

enum DevicePlatform {
  ios,
  android,
  macOS,
  linux,
  windows,
  web,
  other,
}

enum DeviseSizeType {
  small,
  medium,
  large;
}

class Device {
  final BuildContext context;
  Device.of(this.context);

  DeviceType get deviceType {
    if (platform == DevicePlatform.web ||
        platform == DevicePlatform.windows ||
        platform == DevicePlatform.macOS ||
        platform == DevicePlatform.linux) {
      return DeviceType.desktop;
    } else if (deviceSizeType == DeviseSizeType.small) {
      return DeviceType.phone;
    } else {
      return DeviceType.tablet;
    }
  }

  /// ---------------------------------------------------------------- inputType
  InputType get inputType {
    if (platform == DevicePlatform.web ||
        platform == DevicePlatform.windows ||
        platform == DevicePlatform.macOS ||
        platform == DevicePlatform.linux) {
      return InputType.mouse;
    } else {
      return InputType.touch;
    }
  }

  /// ----------------------------------------------------------------- platform
  DevicePlatform get platform {
    if (kIsWeb) return DevicePlatform.web;
    if (Platform.isIOS) return DevicePlatform.ios;
    if (Platform.isAndroid) return DevicePlatform.android;
    if (Platform.isLinux) return DevicePlatform.linux;
    if (Platform.isMacOS) return DevicePlatform.macOS;
    if (Platform.isWindows) return DevicePlatform.windows;
    return DevicePlatform.other;
  }

  /// ----------------------------------------------------------- deviceSizeType
  DeviseSizeType get deviceSizeType {
    if (width > 1000) return DeviseSizeType.large;
    if (width > 600) return DeviseSizeType.medium;
    return DeviseSizeType.small;
  }

  /// -------------------------------------------------------------------- width
  double get width => MediaQuery.of(context).size.width;

  /// ------------------------------------------------------------------- height
  double get height => MediaQuery.of(context).size.height;

  /// ------------------------------------------------------------- shortestSize
  double get shortestSize => MediaQuery.of(context).size.shortestSide;
}
