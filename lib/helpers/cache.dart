import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  static SharedPreferences? _preferences;

  static Future<SharedPreferences> get preferences async {
    _preferences ??= await SharedPreferences.getInstance();
    return _preferences!;
  }

  static Future<void> setString(String key, String value) async {
    final prefs = await preferences;
    await prefs.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    final prefs = await preferences;
    return prefs.getString(key);
  }

  static Future<void> remove(String key) async {
    final prefs = await preferences;
    await prefs.remove(key);
  }

  static Future<void> clear() async {
    final prefs = await preferences;
    await prefs.clear();
  }
}
