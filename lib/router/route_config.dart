import 'package:flutter/material.dart';
import 'package:flutter_base/models/entities/notification/notification_entity.dart';
import 'package:flutter_base/ui/pages/auth/sign_in/sign_in_page.dart';
import 'package:flutter_base/ui/pages/auth/sign_up/sign_up_page.dart';
import 'package:flutter_base/ui/pages/home/home_page.dart';
import 'package:flutter_base/ui/pages/notification/notification_detail/notification_detail_page.dart';
import 'package:flutter_base/ui/pages/notification/notification_list/notification_list_page.dart';
import 'package:flutter_base/ui/pages/onboarding/onboarding_page.dart';
import 'package:flutter_base/ui/pages/photo_view_page/photo_view_page.dart';
import 'package:flutter_base/ui/pages/profile/profile_page.dart';
import 'package:flutter_base/ui/pages/profile/update_avatar/update_avatar_page.dart';
import 'package:flutter_base/ui/pages/profile/update_profile/update_profile_page.dart';
import 'package:flutter_base/ui/pages/splash/splash_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();

  static final navigationKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    routes: _routes,
    debugLogDiagnostics: true,
    navigatorKey: navigationKey,
  );

  ///main page
  static const String splash = "/";
  static const String main = "main";
  static const String signIn = "signIn";
  static const String signUp = "signUp";
  static const String notificationList = "notificationList";
  static const String notificationDetail = "notificationDetail";
  static const String onBoarding = 'onBoarding';
  static const String movieDetail = 'movieDetail';
  static const String photoView = 'photoView';
  static const String profile = 'profile';
  static const String setting = 'setting';
  static const String updateProfile = 'updateProfile';
  static const String updateAvatar = 'updateAvatar';

  // GoRouter configuration
  static final _routes = <RouteBase>[
    GoRoute(
        path: splash,
        builder: (context, state) => const SplashPage(),
        routes: <RouteBase>[
          GoRoute(
            name: main,
            path: main,
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            name: signIn,
            path: signIn,
            builder: (context, state) => const SignInPage(),
          ),
          GoRoute(
            name: signUp,
            path: signUp,
            builder: (context, state) => const SignUpPage(),
          ),
          GoRoute(
            name: notificationList,
            path: notificationList,
            builder: (context, state) => const NotificationListPage(),
          ),
          GoRoute(
            name: notificationDetail,
            path: "notificationDetail",
            builder: (context, state) => NotificationDetailPage(
              arguments: NotificationDetailArguments(
                  //Todo
                  notification: NotificationEntity()),
            ),
          ),
          GoRoute(
            name: onBoarding,
            path: onBoarding,
            builder: (context, state) => const OnboardingPage(),
          ),
          GoRoute(
            name: photoView,
            path: photoView,
            builder: (context, state) => PhotoViewPage(
              arguments:
                  PhotoViewArguments(images: state.extra as List<String>),
            ),
          ),
          GoRoute(
            name: updateProfile,
            path: updateProfile,
            builder: (context, state) => const UpdateProfilePage(),
          ),
          GoRoute(
            name: updateAvatar,
            path: updateAvatar,
            builder: (context, state) => const UpdateAvatarPage(),
          ),
          GoRoute(
            name: profile,
            path: profile,
            builder: (context, state) => const ProfilePage(),
          ),
        ]),
  ];
}
