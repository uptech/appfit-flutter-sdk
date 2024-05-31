import 'package:appfit/networking/managers/device_manager.dart';
import 'package:appfit/networking/properties/operating_system/operating_system_name.dart';
import 'package:mocktail/mocktail.dart';

class MockDeviceManager extends Mock implements DeviceManager {}

extension MockDeviceManagerExt on MockDeviceManager {
  void macOS() {
    when(() => current()).thenAnswer(
      (_) => Future.value(
        const DeviceInfo(
          operatingSystem: OperatingSystemName.macOS,
          operatingSystemVersion: '14.4.1',
          deviceManufacturer: 'Apple',
          deviceModel: 'MacBookPro18,4',
        ),
      ),
    );
  }
}
