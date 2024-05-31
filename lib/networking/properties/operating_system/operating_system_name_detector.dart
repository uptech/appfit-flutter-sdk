import 'dart:io';

import 'package:appfit/networking/properties/operating_system/operating_system_name.dart';
import 'package:flutter/foundation.dart';

class OperatingSystemNameDetector {
  static OperatingSystemName current() {
    if (Platform.isIOS) {
      return OperatingSystemName.iOS;
    } else if (Platform.isMacOS) {
      return OperatingSystemName.macOS;
    } else if (Platform.isAndroid) {
      return OperatingSystemName.android;
    } else if (Platform.isWindows) {
      return OperatingSystemName.windows;
    } else if (Platform.isLinux) {
      return OperatingSystemName.linux;
    } else if (kIsWeb) {
      return OperatingSystemName.web;
    } else {
      return OperatingSystemName.unknown;
    }
  }
}
