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

  /// Show dialog
  Future<void> showSimpleDialog({
    String title = "Alert",
    String message = "",
    String? textConfirm = "Yes",
    String? textCancel = "No",
    barrierDismissible = false,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            textConfirm != null
                ? TextButton(
                    child: Text(textConfirm),
                    onPressed: () {
                      Navigator.of(context).pop();
                      onConfirm?.call();
                    },
                  )
                : const SizedBox(),
            textCancel != null
                ? TextButton(
                    child: const Text('Yes'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      onConfirm?.call();
                    },
                  )
                : const SizedBox(),
          ],
        );
      },
    );
  }

  /// Show error flushbar
  void showErrorFlushbar({required String message}) {
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
      backgroundColor: Colors.redAccent,
    ).show(context);
  }

  void showSuccessFlushbar({required String message}) {
    Flushbar(
      message: message,
      flushbarStyle: FlushbarStyle.GROUNDED,
      flushbarPosition: FlushbarPosition.TOP,
      icon: const Icon(
        Icons.check_circle_outline,
        size: 28.0,
        color: Colors.white,
      ),
      titleColor: Colors.white,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.green,
    ).show(context);
  }
}
