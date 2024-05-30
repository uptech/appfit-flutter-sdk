/// An event that is tracked by AppFit.
class MetricPayload {
  /// The unique identifier for the event.
  final String sourceEventId;

  /// The name of the event.
  final String eventName;

  /// The user identifier for the event.
  /// Note: Either [userId] or [anonymousId] must be provided.
  final String? userId;

  /// The anonymous identifier for the event.
  /// Note: Either [userId] or [anonymousId] must be provided.
  final String? anonymousId;

  /// The properties of the event.
  ///
  /// These are the custom properties of the event. These must be string-based
  /// key-value pairs.
  /// example:
  /// ```dart
  /// {
  ///  'count': '123',
  /// }
  final Map<String, dynamic>? properties;

  /// The system properties of the event.
  /// Note: These are automatically added by the SDK and should not be modified.
  final Map<String, dynamic>? systemProperties;

  /// Creates a new instance of [MetricPayload].
  const MetricPayload({
    required this.sourceEventId,
    required this.eventName,
    this.userId,
    this.anonymousId,
    this.properties,
    this.systemProperties,
  });

  /// Allows you to create a new instance of the [MetricPayload] with updated values.
  MetricPayload copyWith({
    String? sourceEventId,
    String? eventName,
    DateTime? occurredAt,
    String? userId,
    String? anonymousId,
    Map<String, String>? properties,
    Map<String, String>? systemProperties,
  }) {
    return MetricPayload(
      sourceEventId: sourceEventId ?? this.sourceEventId,
      eventName: eventName ?? this.eventName,
      userId: userId ?? this.userId,
      anonymousId: anonymousId ?? this.anonymousId,
      properties: properties ?? this.properties,
      systemProperties: systemProperties ?? this.systemProperties,
    );
  }

  /// Creates a new instance of [MetricPayload] from a JSON object.
  factory MetricPayload.fromJson(Map<String, dynamic> json) {
    return MetricPayload(
      sourceEventId: json['sourceEventId'],
      eventName: json['eventName'],
      userId: json['userId'],
      anonymousId: json['anonymousId'],
      properties: json['properties'],
      systemProperties: json['systemProperties'],
    );
  }

  /// Converts the [MetricPayload] to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'version': "2",
      'sourceEventId': sourceEventId,
      'eventName': eventName,
      'origin': 'flutter',
      'userId': userId,
      'anonymousId': anonymousId,
      'properties': properties,
      'systemProperties': systemProperties,
    };
  }
}
