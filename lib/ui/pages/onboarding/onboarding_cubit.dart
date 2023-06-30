import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base/database/share_preferences_helper.dart';
import 'package:flutter_base/router/route_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState());

  void onPageChanged(int currentIndex) {
    emit(state.copyWith(activePage: currentIndex));
  }

  void setTotalPage({required int totalPage}) {
    emit(state.copyWith(totalPage: totalPage));
  }

  void onNextPage({
    required int nextPage,
    required BuildContext context,
  }) {
    if (nextPage < state.totalPage) {
      emit(state.copyWith(activePage: nextPage));
    } else {
      SharedPreferencesHelper.setOnboard();
      //Todo
      // Get.offAllNamed(RouteConfig.signIn);
    }
  }
}
