import 'package:appfit/appfit.dart';
import 'package:appfit/networking/event_digester.dart';

/// AppFit handles all of the event tracking for the AppFit dashboard.
///
/// To use the AppFit SDK, you must first initialize it with an [AppFitConfiguration].
/// ```dart
/// final configuration = AppFitConfiguration(apiKey: 'key');
/// final appfit = AppFit(configuration: configuration);
/// appfit.trackEvent('event');
/// ```
/// {@category Tracking}
class AppFit {
  /// The configuration for the AppFit SDK.
  final AppFitConfiguration configuration;

  late EventDigester _eventDigester;

  /// Initializes the AppFit SDK with the provided [configuration].
  AppFit({
    required this.configuration,
  }) {
    _eventDigester = EventDigester(
      apiKey: configuration.apiKey,
      projectId: configuration.projectId,
    );
  }

  /// Tracks an event with the provided [eventName] and [eventProperties].
  ///
  /// This is used to track events in the AppFit dashboard.
  void trackEvent(
    String eventName, {
    Map<String, String>? eventProperties,
  }) {
    track(AppFitEvent(name: eventName, properties: eventProperties));
  }

  /// Tracks an event with the provided [event].
  ///
  /// This is used to track events in the AppFit dashboard.
  void track(AppFitEvent event) async {
    await _eventDigester.digest(event);
  }
}
