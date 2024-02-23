import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppShadow {
  AppShadow._();

  static final defaultShadow = [
    const BoxShadow(
      color: AppColors.shadow,
      blurRadius: 4,
      offset: Offset(0, 4),
    ),
  ];

  static final appBarShadow = [
    const BoxShadow(
      color: AppColors.shadow,
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ];
}
