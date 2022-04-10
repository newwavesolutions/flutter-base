import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

class MainState extends Equatable {
  int selectedIndex;

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
