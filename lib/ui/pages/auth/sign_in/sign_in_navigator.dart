import 'package:flutter/cupertino.dart';
import 'package:flutter_base/common/app_navigator.dart';
import 'package:flutter_base/router/route_config.dart';
import 'package:go_router/go_router.dart';

class SignInNavigator extends AppNavigator {
  SignInNavigator({required BuildContext context}) : super(context: context);

  void openMainPage() {
    GoRouter.of(context).pushNamed(AppRouter.main);
  }
}
