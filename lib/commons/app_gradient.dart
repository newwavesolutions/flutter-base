import 'package:flutter/material.dart';
import 'package:flutter_base/commons/app_colors.dart';

class AppGradient {
  static final linearGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    // colors: [AppColors.gradientStart, AppColors.gradientEnd], //Flutter bug
  );
}
