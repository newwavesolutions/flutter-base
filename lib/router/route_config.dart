import 'package:flutter/cupertino.dart';
import 'package:flutter_base/ui/pages/auth/sign_in/sign_in_page.dart';
import 'package:flutter_base/ui/pages/home/home_page.dart';
import 'package:flutter_base/ui/pages/main/main_page.dart';
import 'package:flutter_base/ui/pages/notification/notification_list/notification_list_page.dart';
import 'package:flutter_base/ui/pages/onboarding/onboarding_page.dart';
import 'package:flutter_base/ui/pages/splash/splash_page.dart';
import 'package:go_router/go_router.dart';

class GoRouterConfig {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  /// Route observer to use with RouteAware
  static RouteObserver<ModalRoute<void>> routeObserver =
      RouteObserver<ModalRoute<void>>();

  static GoRouter router(BuildContext context) {
    return GoRouter(
      initialLocation: '/${SplashPage.router}',
      navigatorKey: rootNavigatorKey,
      routes: [
        GoRoute(
            path: '/${SplashPage.router}',
            builder: (BuildContext context, GoRouterState state) {
              return const SplashPage();
            },
            routes: const <GoRoute>[]),
        GoRoute(
            path: '/${OnBoardingPage.router}',
            builder: (BuildContext context, GoRouterState state) {
              return const OnBoardingPage();
            },
            routes: const <GoRoute>[]),
        GoRoute(
            path: '/${SignInPage.router}',
            builder: (BuildContext context, GoRouterState state) {
              return const SignInPage();
            },
            routes: const <GoRoute>[]),
        GoRoute(
            path: '/${MainPage.router}',
            builder: (BuildContext context, GoRouterState state) {
              return const MainPage();
            },
            routes: const <GoRoute>[]),
        GoRoute(
            path: '/${HomePage.router}',
            builder: (BuildContext context, GoRouterState state) {
              return const HomePage();
            },
            routes: const <GoRoute>[]),
        GoRoute(
            path: '/${NotificationListPage.router}',
            builder: (BuildContext context, GoRouterState state) {
              return const NotificationListPage();
            },
            routes: const <GoRoute>[]),
      ],
      observers: [
        routeObserver,
      ],
      redirect: (context, state) {
        return null;
      },
      debugLogDiagnostics: true,
    );
  }
}
