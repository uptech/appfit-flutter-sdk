import 'package:appfit/networking/raw_metric_event.dart';

class BatchRawMetricEvents {
  final List<RawMetricEvent> events;

  BatchRawMetricEvents({required this.events});

  factory BatchRawMetricEvents.fromJson(Map<String, dynamic> json) {
    return BatchRawMetricEvents(
      events: (json['events'] as List)
          .map((e) => RawMetricEvent.fromJson(e as Map<String, dynamic>))
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
