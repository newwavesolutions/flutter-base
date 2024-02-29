import 'package:flutter_base/common/app_navigator.dart';
import 'package:flutter_base/router/route_config.dart';

class SignInNavigator extends AppNavigator {
  SignInNavigator({required super.context});

  void openSignUpPage() {
    pushNamed(AppRouter.signUp);
  }
}
