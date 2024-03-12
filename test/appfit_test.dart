import 'package:appfit/appfit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AppFit Configuration', () {
    final configuration = AppFitConfiguration(apiKey: 'key');
    expect(configuration.apiKey, 'key');
  });

  test('AppFit Class', () {
    final configuration = AppFitConfiguration(apiKey: 'key');
    final appfit = AppFit(configuration: configuration);
    expect(appfit.configuration.apiKey, 'key');
  });

  test('AppFit Event', () {
    final event = AppFitEvent(name: 'event');
    expect(event.name, 'event');
  });
}
