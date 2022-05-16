import 'package:get/get.dart';

import '../ui/pages/main/main_page.dart';
import '../ui/pages/splash/splash_page.dart';

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
