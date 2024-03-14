/// Configuration for the AppFit SDK.
///
/// This is used to initialize the SDK with the [apiKey] provided by AppFit.
/// {@category Tracking}
class AppFitConfiguration {
  /// The API key provided by AppFit.
  final String apiKey;

  /// Creates a new instance of [AppFitConfiguration].
  AppFitConfiguration({
    required this.apiKey,
  });
}
