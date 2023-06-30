import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_dimens.dart';
import 'package:flutter_base/router/route_config.dart';
import 'package:get/get.dart';

class HomeAppBar extends AppBar {
  HomeAppBar({
    Key? key,
    required Widget avatar,
    // VoidCallback? onSearchPressed,
    VoidCallback? onNotificationPressed,
  }) : super(
          key: key,
          title: const Text("Movie"),
          leading: Center(
            child: InkWell(
              onTap: () {
                Get.toNamed(RouteConfig.proFile);
              },
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
