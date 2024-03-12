library appfit;

/// An event that is tracked by AppFit.
///
/// ```dart
/// final event = AppFitEvent(name: 'event');
/// ```
class AppFitEvent {
  /// The name of the event.
  final String name;

  /// The properties of the event.
  final Map<String, dynamic>? properties;

  /// Creates a new instance of [AppFitEvent].
  AppFitEvent({
    required this.name,
    this.properties,
  });
}
