import 'package:dio/dio.dart';
import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/database/share_preferences_helper.dart';
import 'package:flutter_base/repositories/auth_repository.dart';
import 'package:flutter_base/ui/commons/app_dialog.dart';
import 'package:flutter_base/ui/pages/splash/splash_navigator.dart';
import 'package:flutter_base/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final SplashNavigator navigator;
  final AuthRepository authRepo;
  final AppCubit appCubit;

  SplashCubit({
    required this.navigator,
    required this.authRepo,
    required this.appCubit,
  }) : super(const SplashState());

  void checkLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    final token = await authRepo.getToken();
    if (token == null) {
      if (await SharedPreferencesHelper.isOnboardCompleted()) {
        navigator.openSignInPage();
      } else {
        navigator.openOnboardingPage();
      }
    } else {
      try {
        //Profile
        await appCubit.getProfile();
      } catch (error, s) {
        logger.log(error, stackTrace: s);
        //Check 401
        if (error is DioError) {
          if (error.response?.statusCode == 401) {
            //Todo
            // authService.signOut();
            checkLogin();
            return;
          }
        }
        AppDialog.defaultDialog(
          message: "An error happened. Please check your connection!",
          textConfirm: "Retry",
          onConfirm: () {
            checkLogin();
          },
        );
        return;
      }
      navigator.openMainPage();
    }
  }
}
