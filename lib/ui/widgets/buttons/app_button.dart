import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_dimens.dart';

import '../app_circular_progress_indicator.dart';

class AppButton extends StatelessWidget {
  final String? title;
  final Widget? leadingIcon;
  final Widget? trailingIcon;

  final bool isLoading;

  final double? height;
  final double? width;
  final double? borderWidth;
  final double? cornerRadius;

  final Color? backgroundColor;
  final Color? borderColor;

  final TextStyle? titleStyle;

  final VoidCallback? onPressed;

  const AppButton({
    Key? key,
    this.title,
    this.leadingIcon,
    this.trailingIcon,
    this.isLoading = false,
    this.height,
    this.width,
    this.borderWidth,
    this.cornerRadius,
    this.backgroundColor,
    this.borderColor,
    this.titleStyle,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? AppDimens.buttonHeight,
      width: width ?? double.infinity,
      child: _buildChildWidget(),
    );
  }

  Widget _buildChildWidget() {
    if (isLoading) {
      return const AppCircularProgressIndicator(color: Colors.white);
    } else {
      return InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.transparent,
            borderRadius: BorderRadius.circular(cornerRadius ?? 0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              leadingIcon ?? const SizedBox(),
              if (trailingIcon == null) const Spacer(),
              Text(
                title ?? 'Title',
                style: titleStyle ??
                    const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
              ),
              const Spacer(),
              trailingIcon ?? const SizedBox(),
            ],
          ),
        ),
      );
    }
  }
}
