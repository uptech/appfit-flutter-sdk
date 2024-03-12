library appfit;

import 'package:appfit/appfit.dart';

/// AppFit handles all of the event tracking for the AppFit dashboard.
///
/// To use the AppFit SDK, you must first initialize it with an [AppFitConfiguration].
/// ```dart
/// final configuration = AppFitConfiguration(apiKey: 'key');
/// final appfit = AppFit(configuration: configuration);
/// appfit.trackEvent('event');
/// ```
class AppFit {
  /// The configuration for the AppFit SDK.
  final AppFitConfiguration configuration;

  /// Initializes the AppFit SDK with the provided [configuration].
  AppFit({
    required this.configuration,
  });

  /// Tracks an event with the provided [eventName] and [eventProperties].
  ///
  /// This is used to track events in the AppFit dashboard.
  void trackEvent(String eventName, {Map<String, dynamic>? eventProperties}) {
    final event = AppFitEvent(name: eventName, properties: eventProperties);
    track(event);
  }

  /// Tracks an event with the provided [event].
  ///
  /// This is used to track events in the AppFit dashboard.
  void track(AppFitEvent event) {}
}
