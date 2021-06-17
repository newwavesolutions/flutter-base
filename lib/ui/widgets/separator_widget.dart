import 'package:flutter/material.dart';
import 'package:flutter_base/commons/app_colors.dart';

class SeparatorWidget extends StatelessWidget {
  final EdgeInsets margin;
  final height;
  final width;

  SeparatorWidget({
    this.margin = EdgeInsets.zero,
    this.height = 1.0,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 0.0,
      width: width ?? double.infinity,
      margin: margin,
      color: AppColors.lightGray,
    );
  }
}
