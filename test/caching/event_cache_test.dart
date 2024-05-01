import 'package:appfit/appfit.dart';
import 'package:appfit/caching/event_cache.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../mocks/path_provider_mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('$EventCache -', () {
    setUp(() {
      PathProviderPlatform.instance = MockPathProviderPlatform();
    });

    test('write to disk', () {
      final cache = EventCache(
        writeToDiskInterval: const Duration(seconds: 5),
      );
      cache.clear();

      final event = AppFitEvent(name: 'event');
      cache.add(event);

      expect(cache.events.length, 1);
    });

    test('write multiple to disk', () {
      final cache = EventCache(
        writeToDiskInterval: const Duration(seconds: 5),
      );
      cache.clear();

      cache.add(AppFitEvent(name: 'event 1'));
      cache.add(AppFitEvent(name: 'event 2'));
      cache.add(AppFitEvent(name: 'event 3'));
      cache.add(AppFitEvent(name: 'event 4'));

      expect(cache.events.length, 4);
    });

    test('remove from disk by event', () {
      final cache = EventCache(
        writeToDiskInterval: const Duration(seconds: 5),
      );
      cache.clear();

      final event = AppFitEvent(name: 'event');
      cache.add(event);
      cache.removeBy(event);

      expect(cache.events.length, 0);
    });

    test('remove from disk by key', () {
      final cache = EventCache(
        writeToDiskInterval: const Duration(seconds: 5),
      );
      cache.clear();

      final event = AppFitEvent(name: 'event');
      cache.add(event);
      cache.remove(event.id);

      expect(cache.events.length, 0);
    });
  });
}
