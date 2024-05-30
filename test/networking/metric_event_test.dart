import 'package:appfit/networking/metric_event.dart';
import 'package:appfit/networking/metric_payload.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const payload = MetricPayload(
    sourceEventId: 'sourceEventId',
    eventName: 'event',
  );
  final event = MetricEvent(
    occurredAt: DateTime(DateTime.april),
    payload: payload,
  );

  test('$MetricEvent Encoding', () {
    final json = event.toJson();
    expect(json['payload']['eventName'], 'event');
  });

  test('$MetricEvent Decoding', () {
    final json = {
      "eventSource": "appfit",
      "occurredAt": "2021-04-01T00:00:00.000",
      "payload": {
        "version": "2",
        "sourceEventId": "sourceEventId",
        "eventName": "event",
        "origin": "flutter",
        "userId": null,
        "anonymousId": null,
        "properties": null,
        "systemProperties": null
      }
    };
    final decoded = MetricEvent.fromJson(json);
    expect(decoded.payload.eventName, 'event');
  });
}
