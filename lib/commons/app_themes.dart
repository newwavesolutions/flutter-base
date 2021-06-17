import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppThemes {
  static ThemeData theme = ThemeData(
    primaryColor: AppColors.main,
    primarySwatch: Colors.blue,
    primaryTextTheme: TextTheme(button: TextStyle(color: Colors.white)),
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Arimo',
    cursorColor: AppColors.gray,
  );
}