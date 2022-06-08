import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_dimens.dart';
import 'package:flutter_base/ui/widgets/app_devider.dart';

class MenuItemWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const MenuItemWidget({Key? key, this.title = "", this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.only(
          left: AppDimens.marginNormal,
          top: AppDimens.paddingSmall,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  const Icon(
                    Icons.bookmark_outline_rounded,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: theme.textTheme.bodyText1,
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_right,
                  ),
                  const SizedBox(width: AppDimens.paddingSmall),
                ],
              ),
            ),
            const SizedBox(height: AppDimens.paddingSmall),
            const AppDivider(),
          ],
        ),
      ),
    );
  }
}
