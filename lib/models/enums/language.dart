import 'package:flutter/material.dart';

enum Language {
  english,
  vietnamese,
}

extension LanguageExt on Language {
  Locale get local {
    switch (this) {
      case Language.english:
        return const Locale('en', 'US');
      case Language.vietnamese:
        return const Locale('vi', 'VN');
    }
  }

  String get code {
    switch (this) {
      case Language.english:
        return 'en';
      case Language.vietnamese:
        return 'vi';
    }
  }

  static Language? languageFromCode(String code) {
    if (code == Language.english.code) {
      return Language.english;
    } else if (code == Language.vietnamese.code) {
      return Language.vietnamese;
    } else {
      return null;
    }
  }
}
