import 'package:appfit/networking/metric_payload.dart';

/// A raw metric event.
///
/// THis is the root object of the data that is sent to the AppFit API.
class MetricEvent {
  /// The time the event occurred.
  ///
  /// This is a UTC timestamp.
  final DateTime occurredAt;

  /// The event payload.
  ///
  /// This is the event that is tracked by AppFit.
  /// ```dart
  /// final payload = MetricPayload(
  ///   sourceEventId: 'event_id', // This is the unique identifier for the event,
  ///   eventName: 'event', // This is the name of the event,
  ///   occurredAt: DateTime.now(), // This is the time the event occurred,
  ///   userId: 'user_id', // This is the user identifier for the event,
  ///   anonymousId: 'anonymous_id', // This is the anonymous identifier for the event,
  ///   properties: {'key': 'value'}, // These are the properties of the event
  /// )
  /// ```
  final MetricPayload payload;

  /// Creates a new instance of [MetricEvent].
  const MetricEvent({
    required this.occurredAt,
    required this.payload,
  });

  /// Allows you to create a new instance of the [MetricEvent] with updated values.
  MetricEvent copyWith({
    String? projectId,
    DateTime? occurredAt,
    MetricPayload? payload,
  }) {
    return MetricEvent(
      occurredAt: occurredAt ?? this.occurredAt,
      payload: payload ?? this.payload,
    );
  }

  /// Creates a new instance of [MetricEvent] from a JSON object.
  factory MetricEvent.fromJson(Map<String, dynamic> json) {
    return MetricEvent(
      occurredAt: DateTime.parse(json['occurredAt']),
      payload: MetricPayload.fromJson(json['payload']),
    );
  }

  /// Converts the [MetricEvent] to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'version': "2",
      'eventSource': 'appfit',
      'occurredAt': occurredAt.toUtc().toIso8601String(),
      'payload': payload.toJson(),
    };
  }
}
