import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/commons/app_colors.dart';
import 'package:flutter_base/commons/app_dimens.dart';
import 'package:flutter_base/commons/app_images.dart';
import 'package:flutter_base/commons/app_text_styles.dart';

class AppBarWidget extends StatelessWidget {
  final VoidCallback onBackPressed;
  final String title;

  AppBarWidget({Key key, this.onBackPressed, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimens.appBarHeight,
      child: Row(
        children: [
          SizedBox(width: 14),
          GestureDetector(
            child: onBackPressed != null
                ? Container(
                    width: 44,
                    height: 44,
                    child: Image.asset(AppImages.icWhiteBack),
                  )
                : SizedBox(width: 6),
            onTap: onBackPressed,
          ),
          SizedBox(width: 2),
          Text(
            title ?? "",
            style: AppTextStyle.whiteS18W800,
          )
        ],
      ),
      decoration: BoxDecoration(
        color: AppColors.main,
      ),
    );
  }
}
