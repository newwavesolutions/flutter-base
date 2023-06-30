import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/router/route_config.dart';
import 'package:go_router/go_router.dart';

class AppNavigator {
  BuildContext context;

  AppNavigator({required this.context});

  void pop<T extends Object?>([T? result]) {
    GoRouter.of(context).pop(result);
  }

  void forceSignIn() {
    while (GoRouter.of(context).canPop()) {
      GoRouter.of(context).pop();
    }
    GoRouter.of(context).pushReplacementNamed(AppRouter.signIn);
  }

  void openPhotoView({required List<String> photoUrls}) {
    GoRouter.of(context).push(AppRouter.photoView, extra: photoUrls);
  }

  void flushbarError({required String message}) {
    Flushbar(
      message: message,
      flushbarStyle: FlushbarStyle.GROUNDED,
      flushbarPosition: FlushbarPosition.TOP,
      icon: const Icon(
        Icons.error_outline,
        size: 28.0,
        color: Colors.white,
      ),
      titleColor: Colors.white,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.amber,
    ).show(context);
  }

  void flushbarMesssage({required String message}) {
    Flushbar(
      message: message,
      flushbarStyle: FlushbarStyle.GROUNDED,
      flushbarPosition: FlushbarPosition.TOP,
      icon: const Icon(
        Icons.message_outlined,
        size: 28.0,
        color: Colors.white,
      ),
      titleColor: Colors.white,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.green,
    ).show(context);
  }

  void flushbarWarning({required String message}) {
    Flushbar(
      message: message,
      flushbarStyle: FlushbarStyle.GROUNDED,
      flushbarPosition: FlushbarPosition.TOP,
      icon: const Icon(
        Icons.error_outline,
        size: 28.0,
        color: Colors.white,
      ),
      titleColor: Colors.white,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.amber,
    ).show(context);
  }
}
