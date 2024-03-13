import 'package:appfit/appfit.dart';

class EventCache {
  // TODO: Move this to some persisted disk cache.
  final Map<String, AppFitEvent> _cache = {};

  /// The entries in the cache.
  Map<String, AppFitEvent> get entries => _cache;

  /// Adds the provided [value] to the cache.
  /// This is used to add events to the cache that have not been posted to the network.
  /// This will do a lookup in the cache to find the event that matches the provided [value]
  /// and if it is found, it will remove the old event and add the new one.
  void add(AppFitEvent event) {
    // Determine if the event is already in the cache
    if (_cache.containsKey(event.id)) {
      // If it is, remove the old event and add the new one
      remove(event.id);
    }
    _cache[event.id] = event;
  }

  /// Removes the event with the provided [id] from the cache.
  /// This is used to remove events that have been successfully posted to the network.
  /// This will do a lookup in the cache to find the event that matches the provided [id].
  void remove(String id) {
    _cache.remove(id);
  }

  /// Removes the event with the provided [event] from the cache.
  /// This is used to remove events that have been successfully posted to the network.
  /// This will do a lookup in the cache to find the event that matches the provided [event].
  void removeBy(AppFitEvent event) {
    _cache.removeWhere((key, val) => val == event);
  }

  /// Clears the cache.
  /// This will remove all of the local cached events.
  void clear() {
    _cache.clear();
  }
}
