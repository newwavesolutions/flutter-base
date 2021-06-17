import 'package:flutter/material.dart';
import 'package:flutter_base/commons/app_colors.dart';

class LoadingIndicatorWidget extends StatelessWidget {
  final Color color;

  LoadingIndicatorWidget({this.color = AppColors.main});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          backgroundColor: color,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.main),
        ),
      ),
    );
  }
}
