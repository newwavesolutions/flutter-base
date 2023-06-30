import 'package:flutter_base/models/entities/notification/notification_entity.dart';
import 'package:flutter_base/ui/pages/auth/sign_in/sign_in_page.dart';
import 'package:flutter_base/ui/pages/home/detail_movie_photo_view/detail_movie_photo_view_page.dart';
import 'package:flutter_base/ui/pages/movie_detail/movie_detail_page.dart';
import 'package:flutter_base/ui/pages/notification/notification_list/notification_list_page.dart';
import 'package:go_router/go_router.dart';

import '../ui/pages/main/main_page.dart';
import '../ui/pages/notification/notification_detail/notification_detail_page.dart';
import '../ui/pages/onboarding/onboarding_page.dart';
import '../ui/pages/splash/splash_page.dart';

class AppRouter {
  AppRouter._();

  ///main page
  static const String splash = "/";
  static const String main = "main";
  static const String signIn = "signIn";
  static const String notificationList = "notificationList";
  static const String notificationDetail = "notificationDetail";
  static const String onboarding = 'onboarding';
  static const String movieDetail = 'movieDetail';
  static const String photoView = 'photoView';

  // GoRouter configuration
  static final _routes = <RouteBase>[
    GoRoute(path: splash, builder: (context, state) => const SplashPage()),
    GoRoute(
      name: main,
      path: "/$main",
      builder: (context, state) => const MainPage(),
    ),
    GoRoute(
      name: signIn,
      path: "/signIn",
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      name: notificationList,
      path: "/$notificationList",
      builder: (context, state) => const NotificationListPage(),
    ),
    GoRoute(
      name: notificationDetail,
      path: "/notificationDetail",
      builder: (context, state) => NotificationDetailPage(
        arguments: NotificationDetailArguments(
            //Todo
            notification: NotificationEntity()),
      ),
    ),
    GoRoute(
      name: onboarding,
      path: "/$onboarding",
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      name: movieDetail,
      path: "/$movieDetail",
      builder: (context, state) => MovieDetailPage(
        arguments: MovieDetailArguments(id: 1),
      ),
    ),
    GoRoute(
      name: photoView,
      path: "/$photoView",
      builder: (context, state) => DetailMoviePhotoViewPage(
        arguments: DetailMoviePhotoViewArguments(images: []),
      ),
    ),
  ];

  static get router => GoRouter(
        routes: _routes,
        debugLogDiagnostics: true,
      );
}
