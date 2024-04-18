import 'package:appfit/appfit.dart';
import 'package:appfit/networking/event_digester.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mocks/path_provider_mocks.dart';

void main() {
  const apiKey = 'cHJvamVjdElkOmFwaUtleQ==';

  TestWidgetsFlutterBinding.ensureInitialized();

  group('$AppFit -', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await SharedPreferences.getInstance();

      PathProviderPlatform.instance = MockPathProviderPlatform();
      // This is required because we manually register the Linux path provider when on the Linux platform.
      // Will be removed when automatic registration of dart plugins is implemented.
      // See this issue https://github.com/flutter/flutter/issues/52267 for details
      disablePathProviderPlatformOverride = true;
    });

    test('initialization', () {
      final appfit = AppFit(
        configuration: AppFitConfiguration(apiKey: apiKey),
      );

      expect(appfit.configuration.apiKey, apiKey);
    });

    test('event tracking', () {
      final appfit = AppFit(
        configuration: AppFitConfiguration(apiKey: apiKey),
      );

      appfit.trackEvent('test');
    });

    test('should identify a valid userId', () {
      final appfit = AppFit(
        configuration: AppFitConfiguration(apiKey: apiKey),
      );

      appfit.identifyUser('test');
    });

    test('should identify a null userId', () {
      final appfit = AppFit(
        configuration: AppFitConfiguration(apiKey: apiKey),
      );

      appfit.identifyUser(null);
    });
  });

  group('$AppFit Mocks -', () {
    final mock = EventDigesterMock();
    setUp(() async {
      registerFallbackValue(FakeAppFitEvent());
      when(() => mock.digest(any())).thenAnswer((_) async {});
      when(() => mock.identify(any())).thenAnswer((_) async {});
    });

    test('event tracking', () {
      final appfit = AppFit(
        configuration: AppFitConfiguration(apiKey: apiKey),
        eventDigester: mock,
      );

      final event = FakeAppFitEvent();

      appfit.track(event);

      verify(() => mock.digest(event)).called(1);
    });

    test('should identify a userId', () {
      final appfit = AppFit(
        configuration: AppFitConfiguration(apiKey: apiKey),
        eventDigester: mock,
      );

      appfit.identifyUser('test');

      verify(() => mock.identify('test')).called(1);
    });
  });
}

class EventDigesterMock extends Mock implements EventDigester {}

class FakeAppFitEvent extends Fake implements AppFitEvent {}
