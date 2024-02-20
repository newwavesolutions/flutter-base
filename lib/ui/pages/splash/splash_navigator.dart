import 'package:flutter_base/common/app_navigator.dart';
import 'package:flutter_base/router/route_config.dart';
import 'package:go_router/go_router.dart';

class SplashNavigator extends AppNavigator {
  SplashNavigator({required super.context});

  void openSignInPage() {
    GoRouter.of(context).pushReplacementNamed(AppRouter.signIn);
  }

  void openMainPage() {
    GoRouter.of(context).pushReplacementNamed(AppRouter.main);
  }

  void openOnBoardingPage() {
    GoRouter.of(context).pushReplacementNamed(AppRouter.onBoarding);
  }
}
