import 'package:flutter/material.dart';

class AppDivider extends Divider {
  const AppDivider({
    super.key,
    double super.indent = 0,
    double super.endIndent = 0,
  }) : super(
          color: Colors.grey,
          height: 1,
        );
}
