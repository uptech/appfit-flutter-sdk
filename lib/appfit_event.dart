/// An event that is tracked by AppFit.
///
/// ```dart
/// final event = AppFitEvent(name: 'event');
/// ```
/// {@category Tracking}
class AppFitEvent {
  /// The name of the event.
  final String name;

  /// The properties of the event.
  final Map<String, String>? properties;

  /// The time the event occurred.
  final DateTime occurredAt = DateTime.now();

  /// Creates a new instance of [AppFitEvent].
  AppFitEvent({
    required this.name,
    this.properties,
  });
}
