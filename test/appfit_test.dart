import 'package:appfit/appfit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  const apiKey = 'cHJvamVjdElkOmFwaUtleQ==';

  TestWidgetsFlutterBinding.ensureInitialized();

  group('$AppFit -', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await SharedPreferences.getInstance();
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

      appfit.idendifyUser('test');
    });

    test('should identify a null userId', () {
      final appfit = AppFit(
        configuration: AppFitConfiguration(apiKey: apiKey),
      );

      appfit.idendifyUser(null);
    });
  });
}
