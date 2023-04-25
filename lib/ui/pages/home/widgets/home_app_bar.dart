import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_dimens.dart';
import '../../../widgets/images/app_circle_avatar.dart';

class HomeAppBar2 extends AppBar {
  HomeAppBar2({
    Key? key,
    String avatarUrl = "",
    VoidCallback? onSearchPressed,
    VoidCallback? onSettingPressed,
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
            IconButton(
                onPressed: onSearchPressed, icon: const Icon(Icons.search)),
            IconButton(
                onPressed: onSettingPressed, icon: const Icon(Icons.more_vert)),
          ],
        );
}

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final bool autoImplementLeading;
  final VoidCallback? leadingOnTap;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onSettingPressed;
  final List<Widget>? actions;
  final double elevation;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;
  final bool centerTitle;

  const HomeAppBar({
    Key? key,
    this.title,
    this.autoImplementLeading = true,
    this.onSettingPressed,
    this.onSearchPressed,
    this.actions,
    this.leadingOnTap,
    this.elevation = 0,
    this.bottom,
    this.backgroundColor,
    this.centerTitle = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: autoImplementLeading,
      centerTitle: centerTitle,
      leading: InkWell(
        onTap: leadingOnTap,
        child: const Icon(Icons.menu),
      ),
      toolbarHeight: AppDimens.appBarHeight,
      leadingWidth: 60,
      elevation: elevation,
      title: title != null ? Text(title ?? '') : null,
      actions: actions ?? [
        IconButton(
            onPressed: onSearchPressed, icon: const Icon(Icons.search)),
        IconButton(
            onPressed: onSettingPressed, icon: const Icon(Icons.more_vert)),
      ],
    );
  }

  @override

  Size get preferredSize => _PreferredAppBarSize(kToolbarHeight, bottom?.preferredSize.height);
}

class _PreferredAppBarSize extends Size {
  _PreferredAppBarSize(this.toolbarHeight, this.bottomHeight)
      : super.fromHeight((toolbarHeight ?? kToolbarHeight) + (bottomHeight ?? 0));

  final double? toolbarHeight;
  final double? bottomHeight;
}
