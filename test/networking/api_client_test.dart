import 'dart:convert';

import 'package:appfit/networking/api_client.dart';
import 'package:appfit/networking/batch_metric_events.dart';
import 'package:appfit/networking/metric_event.dart';
import 'package:appfit/networking/metric_payload.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:uuid/uuid.dart';

import '../mocks/system_manager_mocks.dart';

void main() {
  group('$ApiClient Mock Tests -', () {
    final event = MetricEvent(
      occurredAt: DateTime(DateTime.april),
      payload: const MetricPayload(
        sourceEventId: 'eventId',
        eventName: 'event',
      ),
    );

    final dio = Dio();
    final dioAdapter = DioAdapter(dio: dio);
    dio.httpClientAdapter = dioAdapter;

    test('Successfully track event', () async {
      dioAdapter.onPost(
        'https://api.appfit.io/metric-events',
        data: jsonEncode(event.toJson()),
        (request) => request.reply(200, {'message': 'Success!'}),
      );
      final client = ApiClient(
        apiKey: 'apiKey',
        dio: dio,
      );
      final result = await client.track(event);
      expect(result, true);
    });

    test('Unsuccessfully track event', () async {
      dioAdapter.onPost(
        'https://api.appfit.io/metric-events',
        data: jsonEncode(event.toJson()),
        (request) => request.reply(400, {'message': 'Bad Request!'}),
      );
      final client = ApiClient(
        apiKey: 'apiKey',
        dio: dio,
      );
      final result = await client.track(event);
      expect(result, false);
    });

    test('Successfully track batch events', () async {
      dioAdapter.onPost(
        'https://api.appfit.io/metric-events/batch',
        data: jsonEncode(BatchMetricEvents(events: [event]).toJson()),
        (request) => request.reply(200, {'message': 'Success!'}),
      );
      final client = ApiClient(
        apiKey: 'apiKey',
        dio: dio,
      );
      final result = await client.trackAll([event]);
      expect(result, true);
    });
  });

  group('$ApiClient Live Tests -', () {
    final systemManager = MockSystemManager();

    setUp(() async {
      systemManager.macOS();
    });

    test('Successfully track event', () async {
      final event = MetricEvent(
        occurredAt: DateTime.now(),
        payload: MetricPayload(
          sourceEventId: const Uuid().v4(),
          eventName: 'unit_test',
          properties: const {'language': 'dart'},
          anonymousId: 'flutter_75fbf7a3-2197-4353-4a39-baedf4628c68',
          systemProperties: await systemManager.current(),
        ),
      );
      final client = ApiClient(
        apiKey:
            'YjZiODczMjItNTAwNC00YTg5LTg2ZTUtOWI3OWE5ZDA5Mjc3OmQ3OGMyMjVhLTc1YzQtNDY5ZC1iZTk5LTY3ZTZiMWM1ZDI5YQ==',
      );
      final result = await client.track(event);
      expect(result, true);
    });
  });
}
