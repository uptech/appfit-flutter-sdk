import 'package:appfit/appfit.dart';
import 'package:appfit/caching/event_cache.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final cache = EventCache();
  test('$EventCache write to disk', () {
    cache.clear();

    final event = AppFitEvent(name: 'event');
    cache.add(event);

    expect(cache.entries.length, 1);
  });

  test('$EventCache write multiple to disk', () {
    cache.clear();

    cache.add(AppFitEvent(name: 'event 1'));
    cache.add(AppFitEvent(name: 'event 2'));
    cache.add(AppFitEvent(name: 'event 3'));
    cache.add(AppFitEvent(name: 'event 4'));

    expect(cache.entries.length, 4);
  });

  test('$EventCache remove from disk by event', () {
    cache.clear();

    final event = AppFitEvent(name: 'event');
    cache.add(event);
    cache.removeBy(event);

    expect(cache.entries.length, 0);
  });

  test('$EventCache remove from disk by key', () {
    cache.clear();

    final event = AppFitEvent(name: 'event');
    cache.add(event);
    cache.remove(event.id);

    expect(cache.entries.length, 0);
  });
}
