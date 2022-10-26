import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsController with ChangeNotifier {
  final appThemeKey = 'todo_app_theme';
  final appLanguageKey = 'todo_app_language';

  bool _isDarkTheme = false;
  bool _isEnglish = false;
  int _selectedNavigationBar = 0;

  bool get isEnglishLanguage => _isEnglish;
  bool get isDarkTheme => _isDarkTheme;
  int get selectedNavigationBar => _selectedNavigationBar;

  initValue() async {
    final String currentTheme = await getCurrentAppTheme();
    if (currentTheme == 'light') {
      _isDarkTheme = false;
    }
    _isDarkTheme = true;
  }

  AppSettingsController() {
    initValue();
  }

  Future<String> getCurrentAppTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final String currentAppTheme = prefs.getString(appThemeKey) ?? 'light';
    return currentAppTheme;
  }

  Future<String> getCurrentAppLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final String currentAppLanguage = prefs.getString(appLanguageKey) ?? 'vi';
    return currentAppLanguage;
  }

  Future<void> setCurrentAppTheme(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(appThemeKey, theme);
  }

  Future<void> setCurrentAppLanguage(String language) async {
    // language: 'vi', 'eng'
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(appLanguageKey, language);
  }

  void setNavigationBar({required selected}) {
    _selectedNavigationBar = selected;
  }

  dynamic changeAppTheme({required String theme}) async {
    theme == 'dark' ? _isDarkTheme = true : _isDarkTheme = false;
    notifyListeners();

    // Save local
    await setCurrentAppTheme(theme);
  }

  dynamic changeAppLanguage({required String language}) async {
    language == 'eng' ? _isEnglish = true : _isEnglish = false;
    notifyListeners();

    // Save local
    await setCurrentAppLanguage(language);
  }
}
