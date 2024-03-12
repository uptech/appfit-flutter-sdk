import 'dart:convert';
import 'dart:io';

import 'package:appfit/networking/raw_metric_event.dart';
import 'package:dio/dio.dart';

/// The API client for AppFit.
class ApiClient {
  /// The base URL for the API Request.
  final String baseUrl;

  /// The API key for the AppFit project.
  final String apiKey;

  /// The project ID for the AppFit project.
  final String projectId;

  /// The Dio instance for making requests.
  final Dio _dio;

  /// The authorization header for the API request.
  String get _auth => base64.encode(utf8.encode('$apiKey:$projectId'));

  /// Creates a new instance of [ApiClient].
  ApiClient({
    String? baseUrl,
    required this.apiKey,
    required this.projectId,
    Dio? dio,
  })  : baseUrl = baseUrl ?? 'https://api.appfit.com',
        _dio = dio ?? Dio();

  /// Tracks an event.
  ///
  /// This will return `true` if the event was successfully tracked, and `false` otherwise.
  Future<bool> track(RawMetricEvent event) async {
    final updatedMetricEvent = event.payload.copyWith(
      projectId: projectId,
    );
    final updatedEvent = event.copyWith(
      projectId: projectId,
      payload: updatedMetricEvent,
    );
    try {
      final response = await _dio.post(
        "$baseUrl/metric-events",
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Basic $_auth',
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        ),
        data: jsonEncode(updatedEvent.toJson()),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // For now, we are just catching the error and returning false.
      // Eventually, we should log the error and handle it better
      return false;
    }
  }
}
