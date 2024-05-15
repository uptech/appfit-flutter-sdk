import 'dart:convert';
import 'dart:io';

import 'package:appfit/appfit_event.dart';
import 'package:path_provider/path_provider.dart';

class DiskCache {
  Future<List<AppFitEvent>> readDataFromDisk() async {
    // Read the data from disk
    final File file = await _getCacheFile();
    if (await file.exists()) {
      final String data = await file.readAsString();
      if (data.isEmpty) return [];
      final List<dynamic> decoded = jsonDecode(data);
      final List<AppFitEvent> events = [];
      for (final Map<String, dynamic> event in decoded) {
        events.add(AppFitEvent.fromJson(event));
      }
      return events;
    }
    return [];
  }

  Future<void> writeDataToDisk(List<AppFitEvent> cache) async {
    final File file = await _getCacheFile();
    final List<Map<String, dynamic>> data =
        cache.map((e) => e.toJson()).toList();
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
