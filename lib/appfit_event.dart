import 'package:uuid/uuid.dart';

/// An event that is tracked by AppFit.
///
/// ```dart
/// final event = AppFitEvent(name: 'event');
/// ```
/// {@category Tracking}
class AppFitEvent {
  /// The unique identifier for the event.
  /// This is used as a way to identify the event both in the SDK and in the AppFit dashboard.
  late String id;

  /// The name of the event.
  final String name;

  /// The properties of the event.
  final Map<String, dynamic>? properties;

  /// The time the event occurred.
  late DateTime occurredAt;

  /// Creates a new instance of [AppFitEvent].
  AppFitEvent({
    String? id,
    required this.name,
    this.properties,
    DateTime? occurredAt,
  }) {
    this.id = id ?? const Uuid().v4();
    this.occurredAt = occurredAt ?? DateTime.now();
  }

  factory AppFitEvent.fromJson(Map<String, dynamic> json) {
    return AppFitEvent(
      id: json['id'],
      name: json['name'],
      properties: json['properties'],
      occurredAt: DateTime.parse(json['occurredAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'properties': properties,
      'occurredAt': occurredAt.toUtc().toIso8601String(),
    };
  }
}
