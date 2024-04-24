import 'package:appfit/networking/metric_event.dart';
import 'package:appfit/networking/raw_metric_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const metricEvent = MetricEvent(
    eventId: 'eventId',
    name: 'event',
  );
  final rawEvent = RawMetricEvent(
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
      "occurredAt": "2021-04-01T00:00:00.000",
      "payload": {
        "eventId": "eventId",
        "name": "event",
        "eventSource": "appfit",
        "occurredAt": "2021-04-01T00:00:00.000",
        "properties": null,
        "systemProperties": {'origin': 'flutter'}
      }
    };
    final decoded = RawMetricEvent.fromJson(json);
    expect(decoded.payload.name, 'event');
  });
}
