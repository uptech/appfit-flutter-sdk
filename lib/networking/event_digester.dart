import 'dart:async';

import 'package:appfit/appfit.dart';
import 'package:appfit/caching/event_cache.dart';
import 'package:appfit/networking/api_client.dart';
import 'package:appfit/networking/metric_event.dart';
import 'package:appfit/networking/raw_metric_event.dart';

class EventDigester {
  /// The API key for the project.
  final String apiKey;

  /// The unique identifier for the project.
  final String projectId;

  /// The cache for the events.
  final EventCache _cache = EventCache();

  /// The API client for the AppFit dashboard.
  late ApiClient _apiClient;

  /// Initializes the [EventDigester] with the provided [apiKey] and [projectId].
  EventDigester({
    required this.apiKey,
    required this.projectId,
  }) {
    _apiClient = ApiClient(apiKey: apiKey, projectId: projectId);
    Timer.periodic(const Duration(minutes: 15), (timer) {
      _digestCache();
    });
  }

  /// Digests the provided [event].
  ///
  /// This is used to digest the provided [event] and send it to the AppFit dashboard.
  /// Before any event is sent to the AppFit dashboard, it is first added to the cache.
  /// If the event is successfully sent to the AppFit dashboard, it is removed from the cache,
  /// otherwise it will be retried later.
  Future<void> digest(AppFitEvent event) async {
    _cache.add(event);
    final result = await _apiClient.track(_createRawEvent(event));
    // If the network requests succeeds, remove the event from the cache
    if (result) _cache.removeBy(event);
  }

  /// Digests the cache.
  ///
  /// This is used to digest all of the events in the cache that might have failed,
  /// or are pending to be sent to the AppFit dashboard.
  void _digestCache() {
    _cache.entries.forEach((key, value) {
      digest(value);
    });
  }

  /// Creates a [RawMetricEvent] from the provided [event].
  RawMetricEvent _createRawEvent(AppFitEvent event) {
    return RawMetricEvent(
      projectId: projectId,
      occurredAt: event.occurredAt,
      payload: MetricEvent(
        sourceEventId: event.id,
        name: event.name,
        projectId: projectId,
        occurredAt: event.occurredAt,
        anonymousId: '', // TODO: Figure out what this is supposed to be
        properties: event.properties,
      ),
    );
  }
}
