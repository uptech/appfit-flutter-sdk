import 'package:appfit/networking/properties/operating_system/operating_system_name.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo {
  final OperatingSystemName? operatingSystem;
  final String? operatingSystemVersion;
  final String? deviceManufacturer;
  final String? deviceModel;
  final String? userAgent;
  final String? browserName;
  final String? browserVersion;

  const DeviceInfo({
    this.operatingSystem,
    this.operatingSystemVersion,
    this.deviceManufacturer,
    this.deviceModel,
    this.userAgent,
    this.browserName,
    this.browserVersion,
  });
}

class DeviceManager {
  const DeviceManager();

  Future<DeviceInfo?> current() async {
    final deviceInfo = DeviceInfoPlugin();
    switch (OperatingSystemName.current()) {
      case OperatingSystemName.iOS:
        final info = await deviceInfo.iosInfo;
        return DeviceInfo(
          operatingSystem: OperatingSystemName.iOS,
          operatingSystemVersion: info.systemVersion,
          deviceManufacturer: "Apple",
          deviceModel: info.utsname.machine,
        );

      case OperatingSystemName.android:
        final info = await deviceInfo.androidInfo;
        return DeviceInfo(
          operatingSystem: OperatingSystemName.android,
          operatingSystemVersion: info.version.release,
          deviceManufacturer: "Android",
          deviceModel: info.model,
        );

      case OperatingSystemName.macOS:
        final info = await deviceInfo.macOsInfo;
        return DeviceInfo(
          operatingSystem: OperatingSystemName.macOS,
          operatingSystemVersion: info.osRelease,
          deviceManufacturer: "Apple",
          deviceModel: info.model,
        );

      case OperatingSystemName.windows:
        // The required data for this is not available on windows.
        // This will need to be updated in the future.
        return null;

      case OperatingSystemName.linux:
        // The required data for this is not available on windows.
        // This will need to be updated in the future.
        return null;

      case OperatingSystemName.web:
        final info = await deviceInfo.webBrowserInfo;
        return DeviceInfo(
          operatingSystem: info.operatingSystem,
          operatingSystemVersion: null,
          deviceManufacturer: null,
          deviceModel: null,
          userAgent: info.userAgent,
          browserName: info.browserName.name,
          browserVersion: info.appVersion,
        );

      case OperatingSystemName.unknown:
        return const DeviceInfo(
          operatingSystem: OperatingSystemName.unknown,
          operatingSystemVersion: null,
          deviceManufacturer: "Unknown",
          deviceModel: "Unknown",
        );
    }
  }
}

extension OperatingSystem on WebBrowserInfo {
  OperatingSystemName? get operatingSystem {
    if (userAgent == null) return null;
    if (userAgent!.contains("Mac")) {
      return OperatingSystemName.macOS;
    } else if (userAgent!.contains("iPad") ||
        userAgent!.contains("iPhone") ||
        userAgent!.contains("iPod")) {
      return OperatingSystemName.iOS;
    } else if (userAgent!.contains("Android")) {
      return OperatingSystemName.android;
    } else if (userAgent!.contains("Windows")) {
      return OperatingSystemName.windows;
    } else if (userAgent!.contains("Linux")) {
      return OperatingSystemName.linux;
    } else {
      return OperatingSystemName.unknown;
    }
  }
}
