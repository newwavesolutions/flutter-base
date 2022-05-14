import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';

class AppCircularProgressIndicator extends StatelessWidget {
  final Color color;

  const AppCircularProgressIndicator({
    Key? key,
    this.color = AppColors.secondary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          backgroundColor: color,
          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.secondary),
        ),
      ),
    );
  }
}
