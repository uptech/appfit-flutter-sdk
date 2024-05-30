import 'package:appfit/networking/metric_event.dart';

class BatchMetricEvents {
  final List<MetricEvent> events;

  BatchMetricEvents({required this.events});

  factory BatchMetricEvents.fromJson(Map<String, dynamic> json) {
    return BatchMetricEvents(
      events: (json['events'] as List)
          .map((e) => MetricEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final events = this.events.map((e) => e.toJson()).toList();
    return {
      'events': events,
    };
  }
}
