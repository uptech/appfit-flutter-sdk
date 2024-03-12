import 'package:appfit/networking/metric_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final metricEvent = MetricEvent(
    sourceEventId: 'eventId',
    name: 'event',
    projectId: 'priojectId',
    occurredAt: DateTime(DateTime.april),
  );

  test('$MetricEvent Encoding', () {
    final json = metricEvent.toJson();
    expect(json['name'], 'event');
  });

  test('$MetricEvent Decoding', () {
    final json = {
      "sourceEventId": "eventId",
      "name": "event",
      "projectId": "priojectId",
      "eventSource": "appfit",
      "occurredAt": "2021-04-01T00:00:00.000",
      "properties": null,
      "systemProperties": null
    };
    final decoded = MetricEvent.fromJson(json);
    expect(decoded.name, 'event');
  });
}
