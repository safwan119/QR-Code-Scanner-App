import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
class UserIdServices{
  static const _key = 'device_user_id';
  final Uuid _uuid = Uuid();

  Future<String> getOrCreateUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getString(_key);
    if (existing != null && existing.isNotEmpty) {
      return existing;
    }
    final newId = _uuid.v4();
    await prefs.setString(_key, newId);
    return newId;
  }

  Future<void> clearUserId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}