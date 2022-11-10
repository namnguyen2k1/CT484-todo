import 'package:shared_preferences/shared_preferences.dart';

class SharedKey {
  static const authTokenKey = 'todolist_auth_token';
  static const localAccountKey = 'todolist_local_account';
  static const appThemeKey = 'todolist_app_theme';
  static const appLanguageKey = 'todolist_app_language';
  static const appCoverImage = 'todolist_app_cover_image';
  static const appAutoReplayPomodoroKey = 'todolist_app_replay_pomodoro';
}

class SharedPreferencesSerivce {
  Future<void> setString(String key, String data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(key, data);
  }

  Future<void> setStringList(String key, List<String> data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setStringList(key, data);
  }

  Future<void> setInt(String key, int data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt(key, data);
  }

  Future<void> setBool(String key, bool data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(key, data);
  }

  // Get data by key
  Future<String> getString(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key) ?? 'empty';
  }

  Future<List<String>?> getStringList(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList(key);
  }

  Future<int> getInt(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(key) ?? -1;
  }

  Future<bool> getBool(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key) ?? false;
  }

  // Delete data with key
  Future<bool> removeStorage(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.remove(key);
  }

  // Check Contains Key
  Future<bool> isExisted(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.containsKey(key);
  }
}
