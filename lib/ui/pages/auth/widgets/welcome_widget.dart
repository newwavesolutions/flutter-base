import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_images.dart';
import 'package:flutter_base/common/app_text_styles.dart';

class WelcomeWidget extends StatelessWidget {
  final String title;
  final String subTitle;

  const WelcomeWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          AppImages.icLogo,
          height: 72,
          width: 72,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 16),
        Text(
          title,
          style: AppTextStyle.indigoS16Bold,
        ),
        const SizedBox(height: 8),
        Text(
          subTitle,
          style: AppTextStyle.textGreyS12W400,
        ),
      ],
    );
  }
}
