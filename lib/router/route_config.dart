import 'package:flutter_base/ui/pages/auth/sign_in/sign_in_page.dart';
import 'package:flutter_base/ui/pages/home/detail_movie_photo_view/detail_movie_photo_view_page.dart';
import 'package:flutter_base/ui/pages/home/movie_detail/movie_detail_page.dart';
import 'package:flutter_base/ui/pages/notification/notification_list/notification_list_page.dart';
import 'package:flutter_base/ui/pages/onboarding/onboarding_page.dart';
import 'package:flutter_base/ui/pages/notification/notification_detail/notification_detail_page.dart';
import 'package:get/get.dart';

import '../ui/pages/main/main_page.dart';
import '../ui/pages/splash/splash_page.dart';

class RouteConfig {
  RouteConfig._();

  ///main page
  static const String splash = "/splash";
  static const String main = "/main";
  static const String signIn = "/signIn";
  static const String notificationList = "/notificationList";
  static const String notificationDetail = "/notificationDetail";
  static const String onboarding = '/onBoarding';
  static const String movieDetail = '/movieDetail';
  static const String photoView = '/photoView';

  ///Alias ​​mapping page
  static final List<GetPage> getPages = [
    GetPage(name: splash, page: () => const SplashPage()),
    GetPage(name: main, page: () => const MainPage()),
    GetPage(name: signIn, page: () => const SignInPage()),
    GetPage(name: signIn, page: () => const NotificationListPage()),
    GetPage(
      name: notificationDetail,
      page: () => NotificationDetailPage(arguments: Get.arguments),
    ),
    GetPage(name: onboarding, page: () => const OnboardingPage()),
    GetPage(
      name: movieDetail,
      page: () => MovieDetailPage(arguments: Get.arguments),
    ),
    GetPage(
      name: photoView,
      page: () => DetailMoviePhotoViewPage(arguments: Get.arguments),
    ),
  ];
}
