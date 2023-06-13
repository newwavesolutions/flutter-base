import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base/database/share_preferences_helper.dart';
import 'package:flutter_base/repositories/auth_repository.dart';
import 'package:flutter_base/ui/commons/app_dialog.dart';
import 'package:flutter_base/ui/pages/auth/sign_in/sign_in_page.dart';
import 'package:flutter_base/ui/pages/main/main_page.dart';
import 'package:flutter_base/ui/pages/onboarding/onboarding_page.dart';
import 'package:flutter_base/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../repositories/user_repository.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final AuthRepository authRepo;
  final UserRepository userRepo;

  SplashCubit({
    required this.authRepo,
    required this.userRepo,
  }) : super(const SplashState());

  void checkLogin({required BuildContext context}) async {
    await Future.delayed(const Duration(seconds: 2));
    final token = await authRepo.getToken();
    if (token == null) {
      if (await SharedPreferencesHelper.isDoneOnboard()) {
        if (context.mounted) {
          context.go("/${SignInPage.router}");
        }
      } else {
        if (context.mounted) {
          context.go("/${OnBoardingPage.router}");
        }
      }
    } else {
      try {
        //Profile
        await userRepo.getProfile();
        //Todo
        // authService.updateUser(myProfile);
      } catch (error, s) {
        logger.log(error, stackTrace: s);
        //Check 401
        if (error is DioError) {
          if (error.response?.statusCode == 401) {
            //Todo
            // authService.signOut();
            if (context.mounted) {
              checkLogin(context: context);
            }
            return;
          }
        }
        AppDialog.defaultDialog(
          message: "An error happened. Please check your connection!",
          textConfirm: "Retry",
          onConfirm: () {
            checkLogin(context: context);
          },
        );
        return;
      }
      if (context.mounted) {
        context.go("/${MainPage.router}");
      }
    }
  }
}
