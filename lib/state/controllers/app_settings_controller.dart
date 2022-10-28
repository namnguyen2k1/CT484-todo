import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../services/shared_preference_service.dart';
import '../services/local_key.dart';

// 'light', 'dark', 'system'
enum ThemMode { light, dark, system }

// 'vi', 'eng', 'jp', 'chi'
enum LanguageMode { vietnamese, english, japan, china }

class AppSettingsController with ChangeNotifier {
  ThemMode _theme = ThemMode.light;
  LanguageMode _language = LanguageMode.english;

  bool get isEnglishLanguage => _language == LanguageMode.english;
  bool get isDarkTheme => _theme == ThemMode.dark;

  Future<void> _initValue() async {
    // Load Theme
    final String currentTheme = await SharedPreferencesSerivce().getString(
      LocalSavedKey.appThemeKey,
    );
    if (currentTheme == 'light') {
      _theme = ThemMode.light;
    } else if (currentTheme == 'dark') {
      _theme = ThemMode.dark;
    }

    // Load language
    final String currentLanguage = await SharedPreferencesSerivce().getString(
      LocalSavedKey.appLanguageKey,
    );
    if (currentLanguage == 'vi') {
      _language = LanguageMode.vietnamese;
    } else if (currentLanguage == 'eng') {
      _language = LanguageMode.english;
    }

    notifyListeners();
  }

  AppSettingsController() {
    _initValue();
  }

  Future<void> changeAppTheme({required String theme}) async {
    if (theme == 'dark') {
      _theme = ThemMode.dark;
    } else if (theme == 'light') {
      _theme = ThemMode.light;
    }
    await SharedPreferencesSerivce().setString(
      LocalSavedKey.appThemeKey,
      theme,
    );
    notifyListeners();
  }

  Future<void> changeAppLanguage({required String language}) async {
    if (language == 'vi') {
      _language = LanguageMode.vietnamese;
    } else if (language == 'eng') {
      _language = LanguageMode.english;
    }
    await SharedPreferencesSerivce().setString(
      LocalSavedKey.appLanguageKey,
      language,
    );
    notifyListeners();
  }
}
