import 'dart:convert';

import 'package:appfit/networking/api_client.dart';
import 'package:appfit/networking/metric_event.dart';
import 'package:appfit/networking/raw_metric_event.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  final event = RawMetricEvent(
    projectId: 'projectId',
    occurredAt: DateTime(DateTime.april),
    payload: MetricEvent(
      sourceEventId: 'eventId',
      name: 'event',
      projectId: 'projectId',
      occurredAt: DateTime(DateTime.april),
    ),
  );

  final dio = Dio();
  final dioAdapter = DioAdapter(dio: dio);
  dio.httpClientAdapter = dioAdapter;

  test('$ApiClient Successfully track event', () async {
    dioAdapter.onPost(
      'https://api.appfit.io/metric-events',
      data: jsonEncode(event.toJson()),
      (request) => request.reply(200, {'message': 'Success!'}),
    );
    final client = ApiClient(
      apiKey: 'apiKey',
      projectId: 'projectId',
      dio: dio,
    );
    final result = await client.track(event);
    expect(result, true);
  });

  test('$ApiClient Unsuccessfully track event', () async {
    dioAdapter.onPost(
      'https://api.appfit.io/metric-events',
      data: jsonEncode(event.toJson()),
      (request) => request.reply(400, {'message': 'Bad Request!'}),
    );
    final client = ApiClient(
      apiKey: 'apiKey',
      projectId: 'projectId',
      dio: dio,
    );
    final result = await client.track(event);
    expect(result, false);
  });
}
