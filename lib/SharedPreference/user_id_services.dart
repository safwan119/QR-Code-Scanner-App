import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
class UserIdServices{
  static const key = 'device_user_id';
  final Uuid uuid = Uuid();

  Future<String> getOrCreateUserId() async {
    final preference = await SharedPreferences.getInstance();
    final existing = preference.getString(key);
    if (existing != null && existing.isNotEmpty) {
      return existing;
    }
    final newId = uuid.v4();
    await preference.setString(key, newId);
    return newId;
  }

  Future<void> clearUserId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}