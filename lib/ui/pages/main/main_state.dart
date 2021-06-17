part of 'main_cubit.dart';

class MainState extends Equatable {
  final int currentTabIndex;

  MainState({
    this.currentTabIndex = 0,
  });

  MainState copyWith({
    int currentTabIndex,
  }) {
    return MainState(
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [
        this.currentTabIndex,
      ];
}
