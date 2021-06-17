import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/commons/app_colors.dart';
import 'package:flutter_base/commons/app_dimens.dart';
import 'package:flutter_base/commons/app_images.dart';
import 'package:flutter_base/commons/app_text_styles.dart';

import '../../../../commons/app_colors.dart';

class HomeAppBar extends StatelessWidget {
  final VoidCallback onBackPressed;
  final String title;

  HomeAppBar({Key key, this.onBackPressed, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimens.appBarHeight,
      child: Stack(
        children: [
          Row(
            children: [
              SizedBox(width: 16),
              CircleAvatar(),
              Spacer(),
              GestureDetector(
                child: Container(
                  height: double.infinity,
                  width: 48,
                  child: Icon(
                    Icons.search,
                    color: AppColors.buttonNormal,
                  ),
                ),
              ),
              GestureDetector(
                child: Container(
                  height: double.infinity,
                  width: 48,
                  child: Icon(
                    Icons.more_vert,
                    color: AppColors.buttonNormal,
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Image.asset(AppImages.icLogo),
          )
        ],
      ),
    );
  }
}
