import 'package:fluro/fluro.dart';
import './router_handler.dart';

class Routes {
  static String root = "/";

  ///Auth
  static String signIn = "/signIn";
  static String signUp = "/signUp";
  static String forgotPassword = "/forgotPassword";

  ///Home
  static String main = "/main";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = notHandler;
    router.define(root, handler: splashHandler);

    ///Auth
    router.define(signIn, handler: signInHandler);
    router.define(signUp, handler: signUpHandler);
    router.define(forgotPassword, handler: forgotPasswordHandler);

    ///Home
    router.define(main, handler: mainHandler);
  }
}
