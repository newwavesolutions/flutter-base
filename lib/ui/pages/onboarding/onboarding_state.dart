part of 'onboarding_cubit.dart';

class OnboardingState extends Equatable {
  final int activePage;
  final int totalPage;

  const OnboardingState({
    this.activePage = 0,
    this.totalPage = 0,
  });

  OnboardingState copyWith({
    int? activePage,
    int? totalPage,
  }) {
    return OnboardingState(
      activePage: activePage ?? this.activePage,
      totalPage: totalPage ?? this.totalPage,
    );
  }

  @override
  List<Object> get props => [
        activePage,
        totalPage,
      ];
}
