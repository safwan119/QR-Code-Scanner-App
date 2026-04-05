import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class PrefUtils {
  static const String key = 'device_user_id';
  static final Uuid uuid = Uuid();
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

  static Future<void> clearAllData() => _prefs!.clear();

  static Future<String> getOrCreateUserId() async {
    final existing = _prefs!.getString(key);
    if (existing != null && existing.isNotEmpty) {
      return existing;
    }
    final newId = uuid.v4();
    await _prefs!.setString(key, newId);
    return newId;
  }

  static Future<void> clearUserId() async {
    await _prefs!.remove(key);
  }
}
