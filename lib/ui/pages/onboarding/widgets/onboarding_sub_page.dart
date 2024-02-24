import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_dimens.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_base/models/enums/onboarding_step.dart';

class OnboardingSubPage extends StatelessWidget {
  final OnboardingStep onboardingStep;

  const OnboardingSubPage({
    super.key,
    required this.onboardingStep,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.paddingNormal),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 300,
            height: 300,
            color: AppColors.gray1,
          ),
          const SizedBox(height: 24),
          Text(
            onboardingStep.title,
            style: AppTextStyle.blackS18W800,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Text(
            onboardingStep.description,
            style: AppTextStyle.blackS14,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
