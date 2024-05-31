import 'package:appfit/networking/managers/device_manager.dart';
import 'package:appfit/networking/properties/browser_properties.dart';
import 'package:appfit/networking/properties/device_properties.dart';
import 'package:appfit/networking/properties/event_system_properties.dart';
import 'package:appfit/networking/properties/operating_system/operating_system.dart';
import 'package:appfit/networking/properties/operating_system/operating_system_name.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SystemManager {
  /// The device manager
  /// This is used to get the current device properties
  /// such as the device model, manufacturer, and operating system
  /// version
  @visibleForTesting
  final DeviceManager deviceManager;

  const SystemManager({
    this.deviceManager = const DeviceManager(),
  });

  /// Returns the current properties of the system
  Future<EventSystemProperties> current() async {
    String? appVersion;
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      appVersion = packageInfo.version;
    } catch (e) {
      appVersion = null;
    }
    final manager = await deviceManager.current();
    return EventSystemProperties(
        appVersion: appVersion,
        device: DeviceProperties(
          manufacturer: manager?.deviceManufacturer,
          model: manager?.deviceModel,
        ),
        browser: BrowserProperties(
          name: manager?.browserName,
          version: manager?.browserVersion,
          userAgent: manager?.userAgent,
        ),
        operatingSystem: OperatingSystemProperties(
          name: manager?.operatingSystem ?? OperatingSystemName.unknown,
          version: manager?.operatingSystemVersion,
        ));
  }
}
