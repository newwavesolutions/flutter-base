import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainState());

  void changeTab(int index) {
    emit(state.copyWith(currentTabIndex: index));
  }
}
