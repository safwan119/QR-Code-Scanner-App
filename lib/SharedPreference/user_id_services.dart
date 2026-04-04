import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class UserIdServices {
  static const key = 'device_user_id';
  final Uuid uuid = Uuid();
  static SharedPreferences? _prefs;

  static Future<SharedPreferences> get _instance async =>
      _prefs ??= await SharedPreferences.getInstance();
  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences?> init() async {
    _prefs = await _instance;
    return _prefs;
  }
  static Future<bool> setString(String key, String value) async =>
      await _prefs!.setString(key, value);
  static String getString(String key) => _prefs!.getString(key) ?? "";

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
