import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base/database/share_preferences_helper.dart';
import 'package:flutter_base/router/route_config.dart';
import 'package:flutter_base/ui/pages/auth/sign_in/sign_in_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

part 'onboarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(const OnBoardingState());

  void onPageChanged(int currentIndex) {
    emit(state.copyWith(activePage: currentIndex));
  }

  void onNextPage({
    required int nextPage,
    required BuildContext context,
  }) {
    if (nextPage <= 2) {
      emit(state.copyWith(activePage: nextPage));
    } else {
      SharedPreferencesHelper.setOnboard();
      context.go("/${SignInPage.router}");
    }
  }
}
