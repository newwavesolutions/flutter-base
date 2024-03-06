import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_dimens.dart';
import 'package:flutter_base/common/app_shadows.dart';
import 'package:flutter_base/common/app_svgs.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  const AppBarWidget({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.onBackPressed,
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
        leading: showBackButton
            ? Container(
                width: 48,
                height: 48,
                margin: const EdgeInsets.only(right: 8),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      if (onBackPressed == null) {
                        Navigator.of(context).pop();
                      } else {
                        onBackPressed?.call();
                      }
                    },
                    child: Center(child: SvgPicture.asset(AppSVGs.icBack)),
                  ),
                ),
              )
            : const SizedBox(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppDimens.appBarHeight);
}
