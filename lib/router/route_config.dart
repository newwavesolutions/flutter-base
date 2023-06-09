import 'package:flutter_base/ui/pages/auth/verification_phone_number/verification_page.dart';
import 'package:get/get.dart';

import '../ui/pages/auth/sign_in_phone_number/sign_in_phone_number_page.dart';
import '../ui/pages/main/main_page.dart';
import '../ui/pages/splash/splash_page.dart';

class RouteConfig {
  RouteConfig._();

  ///main page
  static const String splash = "/splash";
  static const String main = "/main";
  static const String signIn = "/signIn";
  static const String opt = "/otp";

  ///Alias ​​mapping page
  static final List<GetPage> getPages = [
    GetPage(name: splash, page: () => const SplashPage()),
    GetPage(name: main, page: () => const MainPage()),
    GetPage(name: signIn, page: () => const SignInPhonePage()),
    GetPage(
      name: signIn,
      page: () => VerificationPage(
        arguments: Get.arguments,
      ),
    ),
  ];
}
