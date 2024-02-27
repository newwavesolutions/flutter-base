import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_dimens.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_base/ui/widgets/loading/app_loading_indicator.dart';

class AppOutlineButton extends StatelessWidget {
  //Attributes
  final String title;
  final Color titleColor;
  final double? width;
  final double height;
  final EdgeInsets? padding;

  //Status
  final bool isEnabled;
  final bool isLoading;

  //Action & callback
  final VoidCallback? onPressed;

  const AppOutlineButton({
    super.key,
    this.title = "",
    this.titleColor = AppColors.secondary,
    this.width,
    this.height = AppDimens.buttonHeight,
    this.isLoading = false,
    this.onPressed,
    this.padding =
        const EdgeInsets.symmetric(horizontal: AppDimens.paddingSmall),
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnabled ? onPressed : null,
      child: Container(
        height: height,
        width: width,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.buttonCornerRadius),
          border: Border.all(
            color: AppColors.buttonBorder,
            width: 1,
          ),
        ),
        child: _buildChildWidget(),
      ),
    );
  }

  Widget _buildChildWidget() {
    if (isLoading) {
      return const AppCircularProgressIndicator();
    } else {
      return Center(
        child: title.isNotEmpty
            ? Text(
                title,
                style: AppTextStyle.blueS14Medium.copyWith(
                  color: isEnabled ? titleColor : titleColor.withOpacity(0.4),
                ),
              )
            : Container(),
      );
    }
  }
}
