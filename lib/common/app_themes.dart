import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';

class AppThemes {
  static const _font = 'app.dart';

  bool isDarkMode;
  Brightness brightness;
  Color primaryColor;
  Color secondaryColor;

  AppThemes({
    this.isDarkMode = false,
    this.primaryColor = AppColors.primary,
    this.secondaryColor = AppColors.secondary,
  }) : brightness = isDarkMode ? Brightness.dark : Brightness.light;

  Color get backgroundColor => isDarkMode ? AppColors.background : Colors.white;

  TextTheme get textTheme {
    final textColor = isDarkMode ? Colors.white : Colors.black;
    return TextTheme(
      headline1: TextStyle(fontSize: 96.0, color: textColor),
      headline2: TextStyle(fontSize: 60.0, color: textColor),
      headline3: TextStyle(fontSize: 48.0, color: textColor),
      headline4: TextStyle(fontSize: 34.0, color: textColor),
      headline5: TextStyle(fontSize: 24.0, color: textColor),
      headline6: TextStyle(
          fontSize: 20.0, color: textColor, fontWeight: FontWeight.w500),
      subtitle1: TextStyle(fontSize: 16.0, color: textColor),
      subtitle2: TextStyle(
          fontSize: 14.0, color: textColor, fontWeight: FontWeight.w500),
      bodyText1: TextStyle(fontSize: 16.0, color: textColor),
      bodyText2: TextStyle(fontSize: 14.0, color: textColor),
      button: TextStyle(
          fontSize: 14.0, color: textColor, fontWeight: FontWeight.w500),
      caption: TextStyle(fontSize: 12.0, color: textColor),
      overline: TextStyle(fontSize: 14.0, color: textColor),
    );
  }

  ///Light theme
  ThemeData get theme => ThemeData(
        brightness: brightness,
        primaryColor: primaryColor,
        fontFamily: _font,
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: AppBarTheme(
          color: primaryColor,
          iconTheme: IconThemeData(color: secondaryColor),
        ),
        iconTheme: IconThemeData(
          color: secondaryColor,
        ),
        textTheme: textTheme,
        dividerTheme: const DividerThemeData(
          color: Colors.grey,
        ),
      );
}
