import 'package:flutter_base/common/app_navigator.dart';
import 'package:flutter_base/router/route_config.dart';

class SplashNavigator extends AppNavigator {
  SplashNavigator({required super.context});

  Future<void> openOnboardingPage() {
    return pushNamed(AppRouter.onBoarding);
  }
}
