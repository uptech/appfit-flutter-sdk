library appfit;

import 'dart:convert';

/// Configuration for the AppFit SDK.
///
/// This is used to initialize the SDK with the [apiKey] provided by AppFit.
class AppFitConfiguration {
  /// The API key provided by AppFit.
  final String apiKey;

  /// Creates a new instance of [AppFitConfiguration].
  AppFitConfiguration({
    required this.apiKey,
  });

  List<String> get _splitToken {
    Codec<String, String> codec = utf8.fuse(base64);
    return codec.decode(apiKey).split(':');
  }

  /// The project ID decoded from the [apiKey].
  String get projectId {
    return _splitToken.first;
  }

  /// The API key ID decoded from the [apiKey].
  String get apiKeyId {
    return _splitToken.last;
  }
}
