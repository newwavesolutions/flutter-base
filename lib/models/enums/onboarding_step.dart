import 'package:flutter_base/generated/l10n.dart';

enum OnboardingStep {
  step1,
  step2,
  lastStep,
}

extension OnboardingStepExt on OnboardingStep {
  int get index {
    switch (this) {
      case OnboardingStep.step1:
        return 0;
      case OnboardingStep.step2:
        return 1;
      case OnboardingStep.lastStep:
        return 2;
    }
  }

  static OnboardingStep? stepFromIndex(int index) {
    switch (index) {
      case 0:
        return OnboardingStep.step1;
      case 1:
        return OnboardingStep.step2;
      case 2:
        return OnboardingStep.lastStep;
      default:
        return null;
    }
  }

  OnboardingStep get nextStep {
    switch (this) {
      case OnboardingStep.step1:
        return OnboardingStep.step2;
      case OnboardingStep.step2:
        return OnboardingStep.lastStep;
      case OnboardingStep.lastStep:
        return OnboardingStep.step1;
    }
  }

  String get title {
    switch (this) {
      case OnboardingStep.step1:
        return S.current.onboarding_title_01;
      case OnboardingStep.step2:
        return S.current.onboarding_title_02;
      case OnboardingStep.lastStep:
        return S.current.onboarding_title_03;
    }
  }

  String get description {
    switch (this) {
      case OnboardingStep.step1:
        return S.current.onboarding_description_01;
      case OnboardingStep.step2:
        return S.current.onboarding_description_02;
      case OnboardingStep.lastStep:
        return S.current.onboarding_description_03;
    }
  }
}
