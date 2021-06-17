import 'package:flutter/material.dart';
import 'package:flutter_base/commons/app_colors.dart';
import 'package:flutter_base/commons/app_shadow.dart';
import 'package:shimmer/shimmer.dart';

class LoadingMoreRowWidget extends StatelessWidget {
  final double height;
  final Color color;

  LoadingMoreRowWidget({this.height = 80, this.color = AppColors.main});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Container(
        alignment: Alignment.center,
        child: Container(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            backgroundColor: color,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.gradientStart),
          ),
        ),
      ),
    );
  }
}
