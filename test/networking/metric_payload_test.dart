import 'package:appfit/networking/metric_payload.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const payload = MetricPayload(
    sourceEventId: 'sourceEventId',
    eventName: 'event',
  );

  test('$MetricPayload Encoding', () {
    final json = payload.toJson();
    expect(json['eventName'], 'event');
  });

  test('$MetricPayload Decoding', () {
    final json = {
      "version": "2",
      "sourceEventId": "sourceEventId",
      "eventName": "event",
      "origin": "flutter",
      "userId": null,
      "anonymousId": null,
      "properties": null,
      "systemProperties": null
    };
    final decoded = MetricPayload.fromJson(json);
    expect(decoded.eventName, 'event');
  });
}
