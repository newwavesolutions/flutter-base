import 'package:flutter/cupertino.dart';
import 'package:flutter_base/models/enums/option_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void changeOptionDrawer({
    required OptionDrawer option,
    required BuildContext context,
  }) async {
    if (isClosed) {
      return;
    }
    emit(
      state.copyWith(
        option: option,
      ),
    );
    if (option.value == OptionDrawer.profile.value) {}
  }
}
