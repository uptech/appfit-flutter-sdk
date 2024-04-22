import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:appfit/appfit.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class EventCache {
  final Map<String, AppFitEvent> _cache = {};

  /// The entries in the cache.
  Map<String, AppFitEvent> get entries => _cache;

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
  void clear() async {
    _cache.clear();

    if (!kIsWeb) {
      await _save();
    }
  }

  Future<Map<String, AppFitEvent>> _read() async {
    // Read from disk
    return await _readDataFromDisk();
  }

  Future<void> _save() async {
    // Save the cache to disk
    await _writeDataToDisk();
  }

  Future<Map<String, AppFitEvent>> _readDataFromDisk() async {
    // Read the data from disk
    final File file = await _getCacheFile();
    if (await file.exists()) {
      final String data = await file.readAsString();
      if (data.isEmpty) return {};
      final List<dynamic> decoded = jsonDecode(data);
      final Map<String, AppFitEvent> events = {};
      for (final Map<String, dynamic> event in decoded) {
        events[event['id']] = AppFitEvent.fromJson(event);
      }
      return events;
    }
    return {};
  }

  Future<void> _writeDataToDisk() async {
    final File file = await _getCacheFile();
    final List<Map<String, dynamic>> data =
        _cache.values.map((e) => e.toJson()).toList();
    await file.writeAsString(jsonEncode(data));
  }

  Future<File> _getCacheFile() async {
    final Directory documents = await getApplicationDocumentsDirectory();
    final Directory appfit = Directory('${documents.path}/appfit');
    if (!await appfit.exists()) {
      await appfit.create();
    }
    return File('${documents.path}/appfit/cache.af');
  }
}
