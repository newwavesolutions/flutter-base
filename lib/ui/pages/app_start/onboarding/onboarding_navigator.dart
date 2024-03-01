import 'package:flutter_base/common/app_navigator.dart';
import 'package:flutter_base/router/route_config.dart';

class OnboardingNavigator extends AppNavigator {
  OnboardingNavigator({required super.context});

  void openSignInPage() {
    pushReplacementNamed(AppRouter.signIn);
  }
}
