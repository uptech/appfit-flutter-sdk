import 'dart:convert';
import 'dart:io';

import 'package:appfit/networking/batch_metric_events.dart';
import 'package:appfit/networking/raw_metric_event.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/// The API client for AppFit.
class ApiClient {
  /// The base URL for the API Request.
  final String baseUrl;

  /// The API key for the AppFit project.
  final String apiKey;

  /// The Dio instance for making requests.
  final Dio _dio;

  InternetConnection? _internetConnection;

  /// Creates a new instance of [ApiClient].
  ApiClient({
    String? baseUrl,
    required this.apiKey,
    Dio? dio,
  })  : baseUrl = baseUrl ?? 'https://api.appfit.io',
        _dio = dio ?? Dio() {
    if (!kIsWeb) {
      _internetConnection = InternetConnection.createInstance(
        customCheckOptions: [
          InternetCheckOption(uri: Uri.parse(this.baseUrl)),
        ],
      );
    } else {
      _internetConnection = null;
    }
  }

  /// Tracks an event.
  ///
  /// This will return `true` if the event was successfully tracked, and `false` otherwise.
  Future<bool> track(RawMetricEvent event) async {
    try {
      final hasInternet = await _hasInternet();
      if (!hasInternet) return false;

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

  /// Tracks events in a batch.
  ///
  /// This will return `true` if the events werwe successfully tracked, and `false` otherwise.
  Future<bool> trackAll(List<RawMetricEvent> events) async {
    try {
      final data = jsonEncode(BatchRawMetricEvents(events: events).toJson());

      final hasInternet = await _hasInternet();
      if (!hasInternet) return false;

      final response = await _dio.post(
        "$baseUrl/metric-events/batch",
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Basic $apiKey',
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        ),
        data: data,
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

  Future<bool> _hasInternet() async {
    // Check if we have internet, if we don't, we can't track the event
    // so lets return false and let upstream handle it.
    if (kIsWeb) {
      return true;
    }
    if (_internetConnection == null) return false;
    return await _internetConnection!.hasInternetAccess;
  }
}
