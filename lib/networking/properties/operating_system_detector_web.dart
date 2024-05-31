import 'package:appfit/networking/properties/operating_system/operating_system_name.dart';
import 'package:flutter/foundation.dart';

class OperatingSystemDetector {
  static OperatingSystemName current() {
    if (kIsWeb) {
      return OperatingSystemName.web;
    } else {
      return OperatingSystemName.unknown;
    }
  }
}
