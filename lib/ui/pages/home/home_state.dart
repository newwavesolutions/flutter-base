import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/enums/option_drawer.dart';

class HomeState extends Equatable {
  final OptionDrawer option;

  const HomeState({
    this.option = OptionDrawer.home,
  });

  HomeState copyWith({
    OptionDrawer? option,
  }) {
    return HomeState(
      option: option ?? this.option,
    );
  }

  @override
  List<Object?> get props => [
        option,
      ];
}
