import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppShadow {
  static final boxShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 4,
      offset: const Offset(15, 5),
    ),
  ];
  static final boxShadowButtonGoogle = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 4,
      offset: const Offset(-5, 0),
    ),
  ];
  static final boxShadowNull = [
    const BoxShadow(
      blurRadius: 4,
      offset: Offset(0, 0),
    ),
  ];
}
