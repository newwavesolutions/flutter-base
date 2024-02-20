import 'package:flutter_base/common/app_navigator.dart';
import 'package:flutter_base/router/route_config.dart';
import 'package:go_router/go_router.dart';

class SignInNavigator extends AppNavigator {
  SignInNavigator({required super.context});

  void openMainPage() {
    GoRouter.of(context).pushNamed(AppRouter.main);
  }
}
