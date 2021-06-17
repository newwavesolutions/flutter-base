import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/ui/pages/forgot_password/forgot_password_page.dart';
import 'package:flutter_base/ui/pages/main/main_page.dart';
import 'package:flutter_base/ui/pages/sign_in/sign_in_page.dart';
import 'package:flutter_base/ui/pages/sign_up/sign_up_page.dart';
import 'package:flutter_base/ui/pages/splash/splash_page.dart';

Handler notHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) => Scaffold(
    body: Center(
      child: Text('$params'),
    ),
  ),
);

Handler splashHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) => SplashPage(),
);

///Auth
Handler signInHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SignInPage();
});
Handler signUpHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SignUpPage();
});
Handler forgotPasswordHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ForgotPasswordPage();
});

///Home
Handler mainHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return MainPage();
});
