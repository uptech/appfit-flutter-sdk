import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void mockDeviceInfo() {
  const channel = MethodChannel('dev.fluttercommunity.plus/device_info');

  handler(MethodCall methodCall) async {
    if (methodCall.method == 'getDeviceInfo') {
      if (Platform.isMacOS) {
        return _macOS;
      }
    }
    return null;
  }

  TestWidgetsFlutterBinding.ensureInitialized();

  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, handler);
}

Map<String, dynamic> _macOS = {
  'computerName': 'Test MacBook Pro',
  'hostName': 'Test-MacBook-Pro.local',
  'arch': 'x86_64',
  'model': 'MacBookPro18,4',
  'kernelVersion':
      'Darwin Kernel Version 20.3.0: Thu Jan 21 00:07:06 PST 2021; root:xnu-7195.81.3~1/RELEASE_X86_64',
  'osRelease': '14.4.1',
  'majorVersion': 14,
  'minorVersion': 4,
  'patchVersion': 1,
  'activeCPUs': 8,
  'memorySize': 17179869184,
  'cpuFrequency': 2800000000,
  'systemGUID': '00000000-0000-1000-8000-000C293C4C7C',
};
