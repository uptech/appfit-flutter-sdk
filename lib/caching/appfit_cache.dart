import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

/// The keys for the AppFit cache.
enum _AppFitCacheKey {
  /// The user id for the AppFit dashboard.
  userId,

  /// The anonymous id for the AppFit dashboard.
  anonymousId,
}

/// The cache for the AppFit SDK.
/// This is used to store the user id and anonymous id for the AppFit dashboard.
class AppFitCache {
  /// Initializes the AppFit cache.
  const AppFitCache();

  /// Sets the [userId] in the cache.
  /// If the [userId] is `null`, it will be removed from the cache.
  /// This is used to identify the user in the AppFit dashboard.
  ///
  /// When setting the [userId], the [anonymousId] will be set to null.
  Future<void> setUserId(String? userId) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    if (userId == null) {
      await sharedPreferences.remove(_AppFitCacheKey.userId.name);
      return;
    }
    await sharedPreferences.setString(_AppFitCacheKey.userId.name, userId);
  }

  /// Returns the [userId] from the cache.
  Future<String?> getUserId() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_AppFitCacheKey.userId.name);
  }

  /// Returns the [anonymousId] from the cache.
  ///
  /// This Generates an anonymous id if one does not exist.
  /// This is used to identify the user in the AppFit dashboard.
  /// This checks to see if a `userId` exists, if it does not, it will generate an anonymous id.
  Future<String?> getAnonymousId() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final currentId =
        sharedPreferences.getString(_AppFitCacheKey.anonymousId.name);
    if (currentId != null) return currentId;

    // If we dont have an anonymousId, we need to generate one.
    final id = const Uuid().v4();
    await sharedPreferences.setString(_AppFitCacheKey.anonymousId.name, id);
    return id;
  }

  /// Clears the cache.
  void clear() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}
