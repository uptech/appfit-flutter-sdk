import 'package:appfit/appfit_event.dart';

// This is a stub class as we dont need this on web. We are not doing any
// caching for web as it stands. This allows us to do a condition import
// in the EventCache class.
class DiskCache {
  Future<List<AppFitEvent>> readDataFromDisk() async {
    return [];
  }

  Future<void> writeDataToDisk(List<AppFitEvent> cache) async {}
}
