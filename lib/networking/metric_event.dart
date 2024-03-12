/// An event that is tracked by AppFit.
class MetricEvent {
  /// The unique identifier for the event.
  final String sourceEventId;

  /// The name of the event.
  final String name;

  /// The project identifier for the event.
  final String projectId;

  /// The time the event occurred.
  final DateTime occurredAt;

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
  final Map<String, String>? properties;

  /// The system properties of the event.
  /// Note: These are automatically added by the SDK and should not be modified.
  final Map<String, String>? systemProperties;

  /// Creates a new instance of [MetricEvent].
  const MetricEvent({
    required this.sourceEventId,
    required this.name,
    required this.projectId,
    required this.occurredAt,
    this.userId,
    this.anonymousId,
    this.properties,
    this.systemProperties,
  });

  /// Allows you to create a new instance of the [MetricEvent] with updated values.
  MetricEvent copyWith({
    String? sourceEventId,
    String? name,
    String? projectId,
    DateTime? occurredAt,
    String? userId,
    String? anonymousId,
    Map<String, String>? properties,
    Map<String, String>? systemProperties,
  }) {
    return MetricEvent(
      sourceEventId: sourceEventId ?? this.sourceEventId,
      name: name ?? this.name,
      projectId: projectId ?? this.projectId,
      occurredAt: occurredAt ?? this.occurredAt,
      userId: userId ?? this.userId,
      anonymousId: anonymousId ?? this.anonymousId,
      properties: properties ?? this.properties,
      systemProperties: systemProperties ?? this.systemProperties,
    );
  }

  /// Creates a new instance of [MetricEvent] from a JSON object.
  factory MetricEvent.fromJson(Map<String, dynamic> json) {
    return MetricEvent(
      sourceEventId: json['sourceEventId'],
      name: json['name'],
      projectId: json['projectId'],
      occurredAt: DateTime.parse(json['occurredAt']),
      userId: json['userId'],
      anonymousId: json['anonymousId'],
      properties: json['properties'],
      systemProperties: json['systemProperties'],
    );
  }

  /// Converts the [MetricEvent] to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'sourceEventId': sourceEventId,
      'name': name,
      'projectId': projectId,
      'eventSource': 'appfit',
      'occurredAt': occurredAt.toIso8601String(),
      'userId': userId,
      'anonymousId': anonymousId,
      'properties': properties,
      'systemProperties': systemProperties,
    };
  }
}
