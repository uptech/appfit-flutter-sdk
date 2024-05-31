import 'package:appfit/networking/properties/operating_system/operating_system_name_detector.dart'
    if (dart.library.html) 'package:appfit/networking/properties/operating_system_detector_web.dart';

enum OperatingSystemName {
  android('Android'),
  iOS('iOS'),
  macOS('macOS'),
  windows('Windows'),
  linux('Linux'),
  web('Web'),
  unknown('Unknown');

  final String name;
  const OperatingSystemName(this.name);

  static OperatingSystemName current() => OperatingSystemNameDetector.current();
}
