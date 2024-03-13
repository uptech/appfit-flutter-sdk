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
  final String id = const Uuid().v4();

  /// The name of the event.
  final String name;

  /// The properties of the event.
  final Map<String, String>? properties;

  /// The time the event occurred.
  final DateTime occurredAt = DateTime.now().toUtc();

  /// Creates a new instance of [AppFitEvent].
  AppFitEvent({
    required this.name,
    this.properties,
  });
}
