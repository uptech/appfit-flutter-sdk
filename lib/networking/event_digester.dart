import 'dart:async';

import 'package:appfit/appfit.dart';
import 'package:appfit/caching/appfit_cache.dart';
import 'package:appfit/caching/event_cache.dart';
import 'package:appfit/networking/api_client.dart';
import 'package:appfit/networking/metric_event.dart';
import 'package:appfit/networking/metric_payload.dart';

class EventDigester {
  /// The API key for the project.
  final String apiKey;

  /// The cache for the events.
  final EventCache _cache = EventCache();

  /// The cache for the AppFit SDK.
  final AppFitCache _appFitCache = const AppFitCache();

  /// The API client for the AppFit dashboard.
  late ApiClient _apiClient;

  /// Initializes the [EventDigester] with the provided [apiKey] and [projectId].
  EventDigester({
    required this.apiKey,
  }) {
    _apiClient = ApiClient(apiKey: apiKey);

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
    final rawEvent = await _createRawEvent(event);
    final result = await _apiClient.track(rawEvent);

    // If the network requests succeeds, remove the event from the cache
    // otherwise, we want to add it to the cache
    switch (result) {
      case true:
        // For now, so nothing
        break;
      case false:
        _cache.add(event);
        break;
    }
  }

  /// Digests the provided [events].
  ///
  /// This is used to digest the provided [events] and send it to the AppFit dashboard.
  /// Before any event is sent to the AppFit dashboard, it is first added to the cache.
  /// If the event is successfully sent to the AppFit dashboard, it is removed from the cache,
  /// otherwise it will be retried later.
  Future<void> batchDigest(List<AppFitEvent> events) async {
    final rawEvents =
        await Future.wait(events.map((e) async => await _createRawEvent(e)));
    final result = await _apiClient.trackAll(rawEvents);

    // If the network requests succeeds, remove the event from the cache
    // otherwise, we want to add it to the cache
    switch (result) {
      case true:
        _cache.clear();
        break;
      case false:
        // For now, we need to do nothing.
        break;
    }
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
  void _digestCache() async {
    await batchDigest(_cache.events);
  }

  /// Creates a [MetricEvent] from the provided [event].
  Future<MetricEvent> _createRawEvent(AppFitEvent event) async {
    final userId = await _appFitCache.getUserId();
    final anonymousId = await _appFitCache.getAnonymousId();

    // We are going to use the system properties to add the origin of the event.
    // This will need to be reworked once we have the SDK actually
    // fetching system properties
    final systemProperties = {
      'origin': 'flutter',
    };

    return MetricEvent(
      occurredAt: event.occurredAt,
      payload: MetricPayload(
        sourceEventId: event.id,
        eventName: event.name,
        userId: userId,
        anonymousId: anonymousId,
        properties: event.properties,
        systemProperties: systemProperties,
      ),
    );
  }
}
