import 'package:flutter/material.dart';

class AppDivider extends Divider {
  const AppDivider({
    Key? key,
    double indent = 0,
    double endIndent = 0,
  }) : super(
          key: key,
          color: Colors.grey,
          height: 1,
          indent: indent,
          endIndent: endIndent,
        );
}
