part of 'onboarding_cubit.dart';

class OnBoardingState extends Equatable {
  final int activePage;

  const OnBoardingState({
    this.activePage = 0,
  });

  OnBoardingState copyWith({
    int? activePage,
  }) {
    return OnBoardingState(activePage: activePage ?? this.activePage);
  }

  @override
  List<Object> get props => [
        activePage,
      ];
}
