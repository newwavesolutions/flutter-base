import 'package:flutter_base/common/app_navigator.dart';
import 'package:flutter_base/router/route_config.dart';
import 'package:go_router/go_router.dart';

class SignUpNavigator extends AppNavigator {
  SignUpNavigator({required super.context});

  void openSignInPage() {
    GoRouter.of(context).pushNamed(AppRouter.signIn);
  }
}
