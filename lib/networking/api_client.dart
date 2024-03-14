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

  /// The Dio instance for making requests.
  final Dio _dio;

  /// Creates a new instance of [ApiClient].
  ApiClient({
    String? baseUrl,
    required this.apiKey,
    Dio? dio,
  })  : baseUrl = baseUrl ?? 'https://api.appfit.io',
        _dio = dio ?? Dio();

  /// Tracks an event.
  ///
  /// This will return `true` if the event was successfully tracked, and `false` otherwise.
  Future<bool> track(RawMetricEvent event) async {
    try {
      final response = await _dio.post(
        "$baseUrl/metric-events",
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Basic $apiKey',
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        ),
        data: jsonEncode(event.toJson()),
      );
      if (response.statusCode == null) return false;
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
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
