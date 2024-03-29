import 'package:appfit/appfit_configuration.dart';
import 'package:appfit/appfit_event.dart';
import 'package:appfit/networking/event_digester.dart';

export 'package:appfit/appfit_configuration.dart';
export 'package:appfit/appfit_event.dart';

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
    );
    // Once we boot up the AppFit SDK, we need to generate an anonymousId
    // and set the userId to null. This is to ensure that we have the most
    // up-to-date information for the events.
    _eventDigester.identify(null);
  }

  /// Tracks an event with the provided [eventName] and [properties].
  ///
  /// This is used to track events in the AppFit dashboard.
  void trackEvent(
    String eventName, {
    Map<String, String>? properties,
  }) {
    track(AppFitEvent(name: eventName, properties: properties));
  }

  /// Tracks an event with the provided [event].
  ///
  /// This is used to track events in the AppFit dashboard.
  void track(AppFitEvent event) async {
    await _eventDigester.digest(event);
  }

  /// Identifies the user with the provided [userId].
  ///
  /// This is used to identify the user in the AppFit dashboard.
  /// If the [userId] is `null`, the user will be un-identified,
  /// resulting in the user being anonymous.
  void identifyUser(String? userId) async {
    await _eventDigester.identify(userId);
  }
}
