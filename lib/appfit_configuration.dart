/// Configuration for the AppFit SDK.
///
/// This is used to initialize the SDK with the [apiKey] provided by AppFit.
/// {@category Tracking}
class AppFitConfiguration {
  /// The API key provided by AppFit.
  final String apiKey;

  /// The version of the app.
  final String? appVersion;

  /// IP Tracking
  /// This allows you to enable/disable IP address tracking
  ///
  /// Note: Disabling this will remove the location data from the event
  final bool enableIpTracking;

  /// Creates a new instance of [AppFitConfiguration].
  AppFitConfiguration({
    required this.apiKey,
    this.appVersion,
    this.enableIpTracking = true,
  });
}
