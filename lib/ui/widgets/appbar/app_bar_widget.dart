import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_dimens.dart';
import 'package:flutter_base/common/app_shadows.dart';
import 'package:flutter_base/common/app_svgs.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showCloseButton;
  final VoidCallback? onClosePressed;

  const AppBarWidget({
    super.key,
    required this.title,
    this.showCloseButton = true,
    this.onClosePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: AppShadow.appBarShadow,
      ),
      child: AppBar(
        title: Text(
          title,
          style: AppTextStyle.blackS14Medium,
        ),
        centerTitle: true,
        leading: const SizedBox(),
        actions: [
          if (showCloseButton)
            Container(
              width: 48,
              height: 48,
              margin: const EdgeInsets.only(right: 8),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    if (onClosePressed == null) {
                      Navigator.of(context).pop();
                    } else {
                      onClosePressed?.call();
                    }
                  },
                  child: Center(child: SvgPicture.asset(AppSVGs.icClose)),
                ),
              ),
            )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppDimens.appBarHeight);
}
