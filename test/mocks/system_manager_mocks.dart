import 'package:appfit/networking/managers/system_manager.dart';
import 'package:appfit/networking/properties/browser_properties.dart';
import 'package:appfit/networking/properties/device_properties.dart';
import 'package:appfit/networking/properties/event_system_properties.dart';
import 'package:appfit/networking/properties/operating_system/operating_system.dart';
import 'package:appfit/networking/properties/operating_system/operating_system_name.dart';
import 'package:mocktail/mocktail.dart';

class MockSystemManager extends Mock implements SystemManager {}

extension MockSystemManagerExt on MockSystemManager {
  void macOS() {
    when(() => current()).thenAnswer(
      (_) => Future.value(
        const EventSystemProperties(
          appVersion: '1.0.0',
          device: DeviceProperties(
            manufacturer: 'Apple',
            model: 'MacBookPro18,4',
          ),
          browser: null,
          operatingSystem: OperatingSystemProperties(
            name: OperatingSystemName.macOS,
            version: '14.4.1',
          ),
        ),
      ),
    );
  }

  void web() {
    when(() => current()).thenAnswer(
      (_) => Future.value(
        const EventSystemProperties(
          appVersion: '1.0.0',
          device: DeviceProperties(
            manufacturer: null,
            model: null,
          ),
          browser: BrowserProperties(
            name: 'Safari',
            version: '14.0.3',
            userAgent:
                'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0.3 Safari/605.1.15',
          ),
          operatingSystem: OperatingSystemProperties(
            name: OperatingSystemName.macOS,
            version: null,
          ),
        ),
      ),
    );
  }
}
