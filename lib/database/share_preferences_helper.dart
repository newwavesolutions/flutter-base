import 'package:flutter_base/models/enums/language.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const _firstRunKey = 'first_run';
  static const _isOnboardedKey = 'is_onboarded';
  static const _currentLanguageKey = 'current_language';

  static Future<bool> isFirstRun() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_firstRunKey) ?? false;
    } catch (e) {
      return false;
    }
  }

  static Future<void> setFirstRun({bool isFirstRun = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_firstRunKey, isFirstRun);
  }

  static Future<bool> isOnboarded() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_isOnboardedKey) ?? false;
    } catch (e) {
      return false;
    }
  }

  static Future<void> setOnboarded({bool isOnboarded = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isOnboardedKey, isOnboarded);
  }

  static Future<Language?> getCurrentLanguage() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final languageCode = prefs.getString(_currentLanguageKey) ?? "";
      return LanguageExt.languageFromCode(languageCode);
    } catch (e) {
      return null;
    }
  }

  static Future<void> setCurrentLanguage(Language language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentLanguageKey, language.code);
  }
}
