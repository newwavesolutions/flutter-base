import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_dimens.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_base/ui/widgets/app_circular_progress_indicator.dart';

class AppTextButton extends StatelessWidget {
  //Attributes
  final String title;
  final double width;
  final double height;
  final double borderWidth;
  final double cornerRadius;
  final Color? borderColor;
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

  final EdgeInsets? padding;

  final List<BoxShadow>? boxShadow;

  final bool isEnabled;

  const AppTextButton({
    super.key,
    this.title = "",
    this.width = double.infinity,
    this.height = AppDimens.buttonHeight,
    this.borderWidth = 0,
    this.cornerRadius = AppDimens.buttonCornerRadius,
    this.borderColor,
    this.backgroundColor = AppColors.buttonBGPrimary,
    this.disableBackgroundColor = AppColors.buttonBGDisabled,
    this.textStyle = AppTextStyle.white,
    this.leadingIcon,
    this.trailingIcon,
    this.isEnable = true,
    this.isLoading = false,
    this.onPressed,
    this.padding,
    this.boxShadow,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnabled ? onPressed : null,
      child: Container(
        height: height,
        width: width,
        padding: padding ?? EdgeInsets.zero,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            cornerRadius,
          ),
          color: isEnabled ? backgroundColor : AppColors.gray1,
          border: borderColor != null
              ? Border.all(
                  color: borderColor!,
                  width: borderWidth,
                )
              : null,
          boxShadow: boxShadow,
        ),
        child: _buildChildWidget(),
      ),
    );
  }

  Widget _buildChildWidget() {
    if (isLoading) {
      return const AppCircularProgressIndicator();
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          leadingIcon ?? Container(),
          Expanded(
            child: Center(
              child: title.isNotEmpty
                  ? Text(
                      title,
                      style: textStyle,
                    )
                  : Container(),
            ),
          ),
          trailingIcon ?? Container(),
        ],
      );
    }
  }
}
