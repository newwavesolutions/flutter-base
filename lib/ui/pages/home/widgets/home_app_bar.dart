import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_dimens.dart';

class HomeAppBar extends AppBar {
  HomeAppBar({
    super.key,
    required Widget avatar,
    required VoidCallback? onNotificationPressed,
    required VoidCallback? onAvatarPressed,
  }) : super(
          title: const Text("Movie"),
          leading: Center(
            child: InkWell(
              onTap: onAvatarPressed,
              child: avatar,
            ),
          ),
          toolbarHeight: AppDimens.appBarHeight,
          leadingWidth: AppDimens.paddingNormal * 2 + 40,
          actions: [
            // IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(
                onPressed: onNotificationPressed,
                icon: const Icon(Icons.notifications)),
          ],
        );
}
