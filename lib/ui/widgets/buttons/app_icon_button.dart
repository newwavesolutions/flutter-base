import 'package:flutter/material.dart';

import 'app_button.dart';

class AppIconButton extends AppButton {
  const AppIconButton({
    Key? key,
    String? title,
    Widget? leadingIcon,
    Widget? trailingIcon,
    bool isLoading = false,
    TextStyle? textStyle,
    Color? backgroundColor,
    VoidCallback? onPressed,
  }) : super(
          key: key,
          title: title,
          leadingIcon: leadingIcon,
          trailingIcon: trailingIcon,
          isLoading: isLoading,
          onPressed: onPressed,
          textStyle: textStyle,
          backgroundColor: backgroundColor,
        );
}
