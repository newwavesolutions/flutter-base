import 'package:flutter_base/ui/pages/main/main_view.dart';
import 'package:flutter_base/ui/pages/splash/splash_view.dart';
import 'package:get/get.dart';

class RouteConfig {
  ///main page
  static const String splash = "/splash";
  static const String main = "/main";

  ///Alias ​​mapping page
  static final List<GetPage> getPages = [
    GetPage(name: splash, page: () => const SplashPage()),
    GetPage(name: main, page: () => const MainPage()),
  ];
}
