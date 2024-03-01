import 'package:flutter_base/common/app_navigator.dart';
import 'package:flutter_base/router/route_config.dart';

class SignUpNavigator extends AppNavigator {
  SignUpNavigator({required super.context});

  void openSignInPage() {
    pushNamed(AppRouter.signIn);
  }
}
