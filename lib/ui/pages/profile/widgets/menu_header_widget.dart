import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_dimens.dart';
import 'package:flutter_base/ui/widgets/app_devider.dart';

class MenuHeaderWidget extends StatelessWidget {
  final String title;

  const MenuHeaderWidget({
    this.title = "",
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: AppDimens.marginNormal, top: AppDimens.marginLarge),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
            ),
          ),
          const SizedBox(height: AppDimens.marginSmall),
          const AppDivider(),
        ],
      ),
    );
  }
}
