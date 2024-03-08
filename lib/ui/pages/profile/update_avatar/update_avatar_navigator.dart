import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_navigator.dart';

class UpdateAvatarNavigator extends AppNavigator {
  UpdateAvatarNavigator({required super.context});

  Future<void> showBottomSheet({required Widget child}) async {
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return child;
      },
    );
  }
}
