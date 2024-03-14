import 'package:appfit/appfit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const apiKey = 'cHJvamVjdElkOmFwaUtleQ==';
  test('$AppFitConfiguration', () {
    final configuration = AppFitConfiguration(apiKey: apiKey);
    expect(configuration.apiKey, apiKey);
  });
}
