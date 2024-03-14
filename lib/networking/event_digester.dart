import 'dart:async';

import 'package:appfit/appfit.dart';
import 'package:appfit/caching/appfit_cache.dart';
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

  /// The cache for the AppFit SDK.
  final AppFitCache _appFitCache = const AppFitCache();

  /// The API client for the AppFit dashboard.
  late ApiClient _apiClient;

  /// Initializes the [EventDigester] with the provided [apiKey] and [projectId].
  EventDigester({
    required this.apiKey,
    required this.projectId,
  }) {
    _apiClient = ApiClient(apiKey: apiKey);
    _appFitCache.generateOrGetAnonymousId();

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
    final rawEvent = await _createRawEvent(event);
    final result = await _apiClient.track(rawEvent);
    // If the network requests succeeds, remove the event from the cache
    if (result) _cache.removeBy(event);
  }

  /// Identifies the user with the provided [userId].
  ///
  /// This is used to identify the user in the AppFit dashboard.
  /// When passing is `null`, the user will be un-identified,
  /// resulting in the user being anonymous.
  Future<void> identify(String? userId) async {
    _appFitCache.setUserId(userId);
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
  Future<RawMetricEvent> _createRawEvent(AppFitEvent event) async {
    final userId = await _appFitCache.getUserId();
    final anonymousId = await _appFitCache.getAnonymousId();
    return RawMetricEvent(
      projectId: projectId,
      occurredAt: event.occurredAt,
      payload: MetricEvent(
        sourceEventId: event.id,
        name: event.name,
        projectId: projectId,
        occurredAt: event.occurredAt,
        userId: userId,
        anonymousId: anonymousId,
        properties: event.properties,
      ),
    );
  }
}
