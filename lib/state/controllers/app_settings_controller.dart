import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:todoapp/ui/modules/utilities/fake_data.dart';
import '../services/shared_preference_service.dart';

// 'light', 'dark', 'system'
enum ThemMode { light, dark, system }

// 'vi', 'eng', 'jp', 'chi'
enum LanguageMode { vietnamese, english, japan, china }

class AppSettingsController with ChangeNotifier {
  ThemMode _theme = ThemMode.light;
  LanguageMode _language = LanguageMode.english;
  bool _autoReplayPomodoroTimer = false;
  String _coverImageUrl = FakeData.coverImages[0]['path'];

  bool get isEnglishLanguage => _language == LanguageMode.english;
  String get coverImageUrl => _coverImageUrl;
  bool get isDarkTheme => _theme == ThemMode.dark;
  bool get isAutoReplayPomodoroTimer => _autoReplayPomodoroTimer;

  Future<void> _initValue() async {
    // Load Theme
    final String currentTheme = await SharedPreferencesSerivce().getString(
      SharedKey.appThemeKey,
    );
    if (currentTheme == 'light') {
      _theme = ThemMode.light;
    } else if (currentTheme == 'dark') {
      _theme = ThemMode.dark;
    }

    // Load language
    final String currentLanguage = await SharedPreferencesSerivce().getString(
      SharedKey.appLanguageKey,
    );
    if (currentLanguage == 'vi') {
      _language = LanguageMode.vietnamese;
    } else if (currentLanguage == 'eng') {
      _language = LanguageMode.english;
    }

    // Load language
    final bool currentStateIsAutoReplayPomodoroTimer =
        await SharedPreferencesSerivce().getBool(
      SharedKey.appAutoReplayPomodoroKey,
    );
    if (currentStateIsAutoReplayPomodoroTimer) {
      _autoReplayPomodoroTimer = true;
    } else {
      _autoReplayPomodoroTimer = false;
    }

    // get coverImage
    final String currentCoverImage = await SharedPreferencesSerivce().getString(
      SharedKey.appCoverImage,
    );
    if (currentCoverImage == 'empty') {
      _coverImageUrl = FakeData.coverImages[0]['path'];
    } else {
      _coverImageUrl = currentCoverImage;
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
      SharedKey.appThemeKey,
      theme,
    );
    notifyListeners();
  }

  Future<void> changeCoverImage({required String imageUrl}) async {
    _coverImageUrl = imageUrl;
    await SharedPreferencesSerivce().setString(
      SharedKey.appCoverImage,
      _coverImageUrl,
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
      SharedKey.appLanguageKey,
      language,
    );
    notifyListeners();
  }

  Future<void> changeStateAutoReplayPomodoroTimer(
      {required bool autoReplay}) async {
    if (autoReplay) {
      _autoReplayPomodoroTimer = true;
    } else {
      _autoReplayPomodoroTimer = false;
    }
    await SharedPreferencesSerivce().setBool(
      SharedKey.appAutoReplayPomodoroKey,
      autoReplay,
    );
    notifyListeners();
  }
}
