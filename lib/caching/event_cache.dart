import 'dart:async';

import 'package:appfit/appfit.dart';
import 'package:flutter/foundation.dart';

import 'disk_cache.dart' if (dart.library.html) 'disk_cache_web.dart';

class EventCache {
  final List<AppFitEvent> _cache = [];

  /// The entries in the cache.
  List<AppFitEvent> get events => _cache;

  final diskCache = DiskCache();

  EventCache({
    Duration writeToDiskInterval = const Duration(minutes: 5),
  }) {
    // We want to ignore all of these things if we are on web.
    if (!kIsWeb) {
      _read().then((values) {
        _cache.clear();
        _cache.addAll(values);
      });

      Timer.periodic(writeToDiskInterval, (timer) async {
        if (_cache.isEmpty) return;

        // Write the cache to disk
        await _save();
      });
    }
  }

  /// Adds the provided [value] to the cache.
  /// This is used to add events to the cache that have not been posted to the network.
  /// This will do a lookup in the cache to find the event that matches the provided [value]
  /// and if it is found, it will remove the old event and add the new one.
  void add(AppFitEvent event) {
    // Determine if the event is already in the cache
    if (_cache.where((e) => e.id == event.id).isNotEmpty) {
      // If it is, remove the old event and add the new one
      remove(event.id);
    }
    _cache.add(event);
  }

  /// Removes the event with the provided [id] from the cache.
  /// This is used to remove events that have been successfully posted to the network.
  /// This will do a lookup in the cache to find the event that matches the provided [id].
  void remove(String id) {
    _cache.removeWhere((event) => event.id == id);
  }

  /// Removes the event with the provided [event] from the cache.
  /// This is used to remove events that have been successfully posted to the network.
  /// This will do a lookup in the cache to find the event that matches the provided [event].
  void removeBy(AppFitEvent event) {
    remove(event.id);
  }

  /// Clears the cache.
  /// This will remove all of the local cached events.
  void clear() async {
    _cache.clear();

    if (!kIsWeb) {
      await _save();
    }
  }

  Future<List<AppFitEvent>> _read() async {
    // Read from disk
    return await diskCache.readDataFromDisk();
  }

  Future<void> _save() async {
    // Save the cache to disk
    await diskCache.writeDataToDisk(_cache);
  }
}
