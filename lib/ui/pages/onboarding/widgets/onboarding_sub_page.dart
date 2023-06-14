import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_text_styles.dart';

class OnboardingSubPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const OnboardingSubPage(
      {Key? key,
      required this.title,
      required this.description,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          width: 300,
          height: 300,
          fit: BoxFit.fill,
        ),
        Text(
          title,
          style: AppTextStyle.blackS18W800,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          description,
          style: AppTextStyle.blackS14,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
