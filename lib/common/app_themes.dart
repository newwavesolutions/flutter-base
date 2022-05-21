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

  Color get backgroundColor =>
      isDarkMode ? AppColors.backgroundDark : AppColors.backgroundLight;

  TextTheme get textTheme {
    final textColor = isDarkMode ? Colors.white : Colors.black;
    return TextTheme(
      displayLarge: TextStyle(fontSize: 96.0, color: textColor),
      displayMedium: TextStyle(fontSize: 60.0, color: textColor),
      displaySmall: TextStyle(fontSize: 48.0, color: textColor),
      headlineMedium: TextStyle(fontSize: 34.0, color: textColor),
      headlineSmall: TextStyle(fontSize: 24.0, color: textColor),
      titleLarge: TextStyle(
          fontSize: 20.0, color: textColor, fontWeight: FontWeight.w500),
      titleMedium: TextStyle(fontSize: 16.0, color: textColor),
      titleSmall: TextStyle(
          fontSize: 14.0, color: textColor, fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(fontSize: 16.0, color: textColor),
      bodyMedium: TextStyle(fontSize: 14.0, color: textColor),
      bodySmall: TextStyle(fontSize: 12.0, color: textColor),
      labelLarge: TextStyle(
          fontSize: 14.0, color: textColor, fontWeight: FontWeight.w500),
      labelSmall: TextStyle(fontSize: 14.0, color: textColor),
    );
  }

  ///Light theme
  ThemeData get theme {
    return ThemeData(
      brightness: brightness,
      primaryColor: primaryColor,
      fontFamily: _font,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
        color: backgroundColor,
        iconTheme:
            IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
        titleTextStyle: isDarkMode
            ? const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)
            : const TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      tabBarTheme: TabBarTheme(
        unselectedLabelColor: isDarkMode ? Colors.white : Colors.black,
        labelColor: Colors.white,
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
}
