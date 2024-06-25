import 'package:appfit/appfit_event.dart';
import 'package:appfit/networking/event_digester.dart';

class EventDigesterStub implements EventDigester {
  @override
  final String apiKey = '';

  @override
  final String? appVersion = null;

  @override
  final bool enableIpTracking = false;

  EventDigesterStub();

  @override
  Future<void> digest(AppFitEvent event) async {}

  @override
  Future<void> batchDigest(List<AppFitEvent> events) async {}

  @override
  Future<void> identify(String? userId) async {}
}
