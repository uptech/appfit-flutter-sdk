/// An event that is tracked by AppFit.
class MetricEvent {
  /// The unique identifier for the event.
  final String eventId;

  /// The name of the event.
  final String name;

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

  /// Creates a new instance of [MetricEvent].
  const MetricEvent({
    required this.eventId,
    required this.name,
    this.userId,
    this.anonymousId,
    this.properties,
    this.systemProperties,
  });

  /// Allows you to create a new instance of the [MetricEvent] with updated values.
  MetricEvent copyWith({
    String? eventId,
    String? name,
    DateTime? occurredAt,
    String? userId,
    String? anonymousId,
    Map<String, String>? properties,
    Map<String, String>? systemProperties,
  }) {
    return MetricEvent(
      eventId: eventId ?? this.eventId,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      anonymousId: anonymousId ?? this.anonymousId,
      properties: properties ?? this.properties,
      systemProperties: systemProperties ?? this.systemProperties,
    );
  }

  /// Creates a new instance of [MetricEvent] from a JSON object.
  factory MetricEvent.fromJson(Map<String, dynamic> json) {
    return MetricEvent(
      eventId: json['eventId'],
      name: json['name'],
      userId: json['userId'],
      anonymousId: json['anonymousId'],
      properties: json['properties'],
      systemProperties: json['systemProperties'],
    );
  }

  /// Converts the [MetricEvent] to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'origin': 'dart',
      'eventId': eventId,
      'name': name,
      'userId': userId,
      'anonymousId': anonymousId,
      'properties': properties,
      'systemProperties': systemProperties,
    };
  }
}
