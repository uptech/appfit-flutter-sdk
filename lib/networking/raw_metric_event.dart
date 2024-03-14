import 'package:appfit/networking/metric_event.dart';

/// A raw metric event.
///
/// THis is the root object of the data that is sent to the AppFit API.
class RawMetricEvent {
  /// The time the event occurred.
  ///
  /// This is a UTC timestamp.
  final DateTime occurredAt;

  /// The event payload.
  ///
  /// This is the event that is tracked by AppFit.
  /// ```dart
  /// final payload = MetricEvent(
  ///   sourceEventId: 'event_id', // This is the unique identifier for the event,
  ///   name: 'event', // This is the name of the event,
  ///   occurredAt: DateTime.now(), // This is the time the event occurred,
  ///   userId: 'user_id', // This is the user identifier for the event,
  ///   anonymousId: 'anonymous_id', // This is the anonymous identifier for the event,
  ///   properties: {'key': 'value'}, // These are the properties of the event,
  ///   systemProperties: {'key': 'value'}, // These are the system properties of the event,
  /// )
  /// ```
  final MetricEvent payload;

  /// Creates a new instance of [RawMetricEvent].
  const RawMetricEvent({
    required this.occurredAt,
    required this.payload,
  });

  /// Allows you to create a new instance of the [RawMetricEvent] with updated values.
  RawMetricEvent copyWith({
    String? projectId,
    DateTime? occurredAt,
    MetricEvent? payload,
  }) {
    return RawMetricEvent(
      occurredAt: occurredAt ?? this.occurredAt,
      payload: payload ?? this.payload,
    );
  }

  /// Creates a new instance of [RawMetricEvent] from a JSON object.
  factory RawMetricEvent.fromJson(Map<String, dynamic> json) {
    return RawMetricEvent(
      occurredAt: DateTime.parse(json['occurredAt']),
      payload: MetricEvent.fromJson(json['payload']),
    );
  }

  /// Converts the [RawMetricEvent] to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'eventSource': 'appfit',
      'occurredAt': occurredAt.toIso8601String(),
      'payload': payload.toJson(),
    };
  }
}
