class InstanceNotFound implements Exception {
  final String message;

  const InstanceNotFound(this.message);
}

class NetworkRequestFailed implements Exception {
  final String message;

  const NetworkRequestFailed(this.message);
}

class TrackingEventFailed implements Exception {
  final String message;

  const TrackingEventFailed(this.message);
}

class FailedReadingCache implements Exception {
  final String message;

  const FailedReadingCache(this.message);
}

class FailedSavingCache implements Exception {
  final String message;

  const FailedSavingCache(this.message);
}
