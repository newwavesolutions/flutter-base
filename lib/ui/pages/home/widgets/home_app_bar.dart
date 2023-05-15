import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_dimens.dart';
import '../../../widgets/images/app_circle_avatar.dart';

class HomeAppBar extends AppBar {
  HomeAppBar({
    Key? key,
    String avatarUrl = "",
    // VoidCallback? onSearchPressed,
    VoidCallback? onNotificationPressed,
  }) : super(
          key: key,
          title: const Text("Movie"),
          leading: Center(
            child: AppCircleAvatar(
              url: avatarUrl,
              size: 40,
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
