import 'package:shared_preferences/shared_preferences.dart';

class UtilShared {
  static late final SharedPreferences instance;

  static Future<SharedPreferences> init() async =>
      instance = await SharedPreferences.getInstance();

  /// Read Integer
  static Future<int> readIntPreference({
    required String key,
  }) async {
    return instance.getInt(key) ?? 0;
  }

  /// Read String
  static Future<String> readStringPreference({
    required String key,
  }) async {
    return instance.getString(key) ?? '';
  }

  /// Read Boolean
  static Future<bool> readBoolPreference({
    required String key,
  }) async {
    return instance.getBool(key) ?? false;
  }

  /// Save Integer
  static Future<void> saveIntPreference({
    required String key,
    required int value,
  }) async {
    instance.setInt(key, value);
  }

  /// Save String
  static Future<void> saveStringPreference({
    required String key,
    required String value,
  }) async {
    instance.setString(key, value);
  }

  /// Save Bool
  static Future<void> saveBoolPreference({
    required String key,
    required bool value,
  }) async {
    instance.setBool(key, value);
  }
}
