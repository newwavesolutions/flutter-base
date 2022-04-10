import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainState());

  ///Switch tab
  void switchTap(int index) {
    emit(state.copyWith(selectedIndex: index));
  }
}
