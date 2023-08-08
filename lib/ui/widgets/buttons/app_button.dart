import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_dimens.dart';
import 'package:flutter_base/common/app_text_styles.dart';

import '../app_circular_progress_indicator.dart';

class AppButton extends StatelessWidget {
  //Attributes
  final String title;
  final double width;
  final double height;
  final double borderWidth;
  final double cornerRadius;
  final Color borderColor;
  final Color backgroundColor;
  final Color disableBackgroundColor;
  final TextStyle textStyle;

  //Child widgets
  final Widget? leadingIcon;
  final Widget? trailingIcon;

  //Status
  final bool isEnable;
  final bool isLoading;

  //Action & callback
  final VoidCallback? onPressed;

  const AppButton({
    Key? key,
    this.title = "",
    this.width = double.infinity,
    this.height = AppDimens.buttonHeight,
    this.borderWidth = 0,
    this.cornerRadius = AppDimens.buttonCornerRadius,
    this.borderColor = AppColors.border,
    this.backgroundColor = AppColors.buttonBGPrimary,
    this.disableBackgroundColor = AppColors.buttonBGDisabled,
    this.textStyle = AppTextStyle.white,
    this.leadingIcon,
    this.trailingIcon,
    this.isEnable = true,
    this.isLoading = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cornerRadius),
          ),
          backgroundColor: isEnable ? backgroundColor : disableBackgroundColor,
          side: BorderSide(
            color: borderColor,
            width: borderWidth,
          ),
          padding: const EdgeInsets.all(0),
        ),
        onPressed: isEnable ? onPressed : null,
        child: _buildChildWidget(),
      ),
    );
  }

  Widget _buildChildWidget() {
    if (isLoading) {
      return const AppCircularProgressIndicator(color: Colors.white);
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          leadingIcon ?? Container(),
          title.isNotEmpty ? Text(title, style: textStyle) : Container(),
          trailingIcon ?? Container(),
        ],
      );
    }
  }
}
