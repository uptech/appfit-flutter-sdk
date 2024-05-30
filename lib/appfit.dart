import 'package:appfit/appfit_configuration.dart';
import 'package:appfit/appfit_event.dart';
import 'package:appfit/networking/event_digester.dart';
import 'package:flutter/foundation.dart';

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
  static Map<String, AppFit>? _instances;

  /// Create a new shared instance of the AppFit SDK with the provided
  /// [configuration] and optional [instanceName].
  ///
  /// If no [instanceName] is provided, the default instance will be created.
  /// ```dart
  /// final appfit = AppFit.createInstance(configuration: configuration);
  /// ```
  ///
  /// The instance can be retrieved using the [getInstance] method below.
  ///
  /// {@category Initialization}
  static AppFit createInstance({
    required AppFitConfiguration configuration,
    String instanceName = "default",
  }) {
    _instances ??= <String, AppFit>{};
    return _instances!.putIfAbsent(
      instanceName,
      () => AppFit(configuration: configuration),
    );
  }

  /// Retrieve the shared instance of the AppFit SDK with the provided
  /// [instanceName].
  /// If no [instanceName] is provided, the default instance will be returned.
  /// ```dart
  /// final appfit = AppFit.getInstance();
  /// ```
  /// Note: If an instance is not configured before calling this method,
  /// an exception will be thrown.
  /// {@category Initialization}
  static AppFit getInstance({
    String instanceName = "default",
  }) {
    _instances ??= <String, AppFit>{};
    return _instances![instanceName]!;
  }

  /// The configuration for the AppFit SDK.
  final AppFitConfiguration configuration;

  /// The event digester for the AppFit SDK.
  ///
  /// This is exposed to allow for Testing overrides
  /// This all.ows you to mock the EventDigester for testing purposes.
  @visibleForTesting
  final EventDigester eventDigester;

  /// Initializes the AppFit SDK with the provided [configuration] and optional
  /// [eventDigester] for testing purposes.
  AppFit({
    required this.configuration,
    EventDigester? eventDigester,
  }) : eventDigester =
            eventDigester ?? EventDigester(apiKey: configuration.apiKey) {
    // Once we boot up the AppFit SDK, we need to generate an anonymousId
    // and set the userId to null. This is to ensure that we have the most
    // up-to-date information for the events.
    this.eventDigester.identify(null);

    // This is a unique event that is used specifically to track when the
    // AppFit SDK has been initialized.
    // This is an internal event.
    trackEvent("appfit_sdk_initialized");
  }

  /// Tracks an event with the provided [eventName] and [properties].
  ///
  /// This is used to track events in the AppFit dashboard.
  void trackEvent(
    String eventName, {
    Map<String, dynamic>? properties,
  }) {
    track(AppFitEvent(name: eventName, properties: properties));
  }

  /// Tracks an event with the provided [event].
  ///
  /// This is used to track events in the AppFit dashboard.
  void track(AppFitEvent event) async {
    await eventDigester.digest(event);
  }

  /// Identifies the user with the provided [userId].
  ///
  /// This is used to identify the user in the AppFit dashboard.
  /// If the [userId] is `null`, the user will be un-identified,
  /// resulting in the user being anonymous.
  void identifyUser(String? userId) async {
    await eventDigester.identify(userId);

    // This is a unique event that is used specifically to track when the
    // AppFit SDK has been identified a user
    // This is an internal event.
    trackEvent("appfit_user_identified");
  }
}
