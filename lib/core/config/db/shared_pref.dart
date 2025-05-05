import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  late final SharedPreferences _prefs;

  // Singleton Instance
  static final SharedPref _instance = SharedPref._internal();
  factory SharedPref() => _instance;

  SharedPref._internal();

  // Initialize SharedPreferences instance
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save methods
  Future<void> setString(String key, String value) async =>
      await _prefs.setString(key, value);

  Future<void> setInt(String key, int value) async =>
      await _prefs.setInt(key, value);

  Future<void> setBool(String key, bool value) async =>
      await _prefs.setBool(key, value);

  Future<void> setDouble(String key, double value) async =>
      await _prefs.setDouble(key, value);

  Future<void> setStringList(String key, List<String> value) async =>
      await _prefs.setStringList(key, value);

  // Get methods with default value fallback
  String getString(String key, {String defaultValue = ''}) =>
      _prefs.getString(key) ?? defaultValue;

  int getInt(String key, {int defaultValue = 0}) =>
      _prefs.getInt(key) ?? defaultValue;

  bool getBool(String key, {bool defaultValue = false}) =>
      _prefs.getBool(key) ?? defaultValue;

  double getDouble(String key, {double defaultValue = 0.0}) =>
      _prefs.getDouble(key) ?? defaultValue;

  List<String> getStringList(String key,
          {List<String> defaultValue = const []}) =>
      _prefs.getStringList(key) ?? defaultValue;

  // Check if a key exists
  bool contains(String key) => _prefs.containsKey(key);

  // Remove a specific key
  Future<void> remove(String key) async => await _prefs.remove(key);

  // Clear all data
  Future<void> clear() async => await _prefs.clear();
}
