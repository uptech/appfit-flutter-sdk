import 'package:appfit/caching/appfit_cache.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('$AppFitCache -', () {
    const cache = AppFitCache();

    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('verify the userId gets saved', () async {
      await cache.setUserId('test');

      final userId = await cache.getUserId();

      expect(userId, 'test');
    });

    test('verify userId is null and an anonymousId is generated', () async {
      await cache.setUserId(null);

      final userId = await cache.getUserId();
      final anonymousId = await cache.getAnonymousId();

      expect(userId, isNull);
      expect(anonymousId, isNotNull);
    });
  });
}
