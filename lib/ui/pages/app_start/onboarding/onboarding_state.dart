part of 'onboarding_cubit.dart';

class OnboardingState extends Equatable {
  final OnboardingStep onboardingStep;

  const OnboardingState({
    this.onboardingStep = OnboardingStep.step1,
  });

  @override
  List<Object> get props => [
        onboardingStep,
      ];

  OnboardingState copyWith({
    OnboardingStep? onboardingStep,
  }) {
    return OnboardingState(
      onboardingStep: onboardingStep ?? this.onboardingStep,
    );
  }
}
