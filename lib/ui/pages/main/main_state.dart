import 'package:equatable/equatable.dart';

class MainState extends Equatable {
  final int selectedIndex;

  MainState({
    this.selectedIndex = 0,
  });

  MainState copyWith({
    int? selectedIndex,
  }) {
    return MainState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props => [
        selectedIndex,
      ];
}
