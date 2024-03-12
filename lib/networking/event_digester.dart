import 'package:appfit/appfit.dart';
import 'package:appfit/caching/event_cache.dart';
// import 'package:appfit/networking/api_client.dart';

class EventDigester {
  final String apiKey;

  final EventCache _cache = EventCache();
  // late ApiClient _apiClient;

  EventDigester({
    required this.apiKey,
  }) {
    // _apiClient = ApiClient(apiKey: apiKey);
    init();
  }

  void init() {
    // TODO: Createa timer that ticks every so often to check the cache
    // and post any events to the network
    // _cache.entries.forEach((key, value) {
    //   digest(value);
    // });
  }

  Future<void> digest(AppFitEvent event) async {
    final timeStamp = DateTime.now();
    _cache.add(timeStamp, event);
    // TODO: Perform the network request
    // If the network requests succeeds, remove the event from the cache
    _cache.remove(timeStamp);
  }
}
