import 'package:appfit/networking/metric_event.dart';
import 'package:appfit/networking/raw_metric_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final metricEvent = MetricEvent(
    sourceEventId: 'eventId',
    name: 'event',
    projectId: 'priojectId',
    occurredAt: DateTime(DateTime.april),
  );
  final rawEvent = RawMetricEvent(
    projectId: 'priojectId',
    occurredAt: DateTime(DateTime.april),
    payload: metricEvent,
  );

  test('$RawMetricEvent Encoding', () {
    final json = rawEvent.toJson();
    expect(json['payload']['name'], 'event');
  });

  test('$RawMetricEvent Decoding', () {
    final json = {
      "eventSource": "appfit",
      "projectId": "priojectId",
      "occurredAt": "2021-04-01T00:00:00.000",
      "payload": {
        "sourceEventId": "eventId",
        "name": "event",
        "projectId": "priojectId",
        "eventSource": "appfit",
        "occurredAt": "2021-04-01T00:00:00.000",
        "properties": null,
        "systemProperties": null
      }
    };
    final decoded = RawMetricEvent.fromJson(json);
    expect(decoded.payload.name, 'event');
  });
}
