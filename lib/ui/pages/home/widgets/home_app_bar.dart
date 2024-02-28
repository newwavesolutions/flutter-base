import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_dimens.dart';
import 'package:flutter_base/common/app_shadows.dart';
import 'package:flutter_base/configs/app_configs.dart';
import 'package:flutter_base/ui/widgets/images/app_circle_avatar.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: AppShadow.appBarShadow,
      ),
      child: AppBar(
        title: const Text(AppConfigs.appName),
        centerTitle: true,
        leading: const SizedBox(),
        actions: const [
          AppCircleAvatar(),
          SizedBox(width: AppDimens.paddingNormal),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppDimens.appBarHeight);
}
