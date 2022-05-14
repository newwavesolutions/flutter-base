import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_shadows.dart';
import 'package:flutter_base/common/app_text_styles.dart';

/// tabController = TabController(length: 2, vsync: this)
/// Page with TickerProviderStateMixin

class AppTabBar extends StatelessWidget {
  final TabController? tabController;
  final List<String> tabItems;

  const AppTabBar({
    Key? key,
    this.tabController,
    this.tabItems = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(19)),
        boxShadow: AppShadow.boxShadow,
      ),
      child: TabBar(
        controller: tabController,
        tabs: buildTabItems(),
        labelStyle: AppTextStyle.blackS14,
        unselectedLabelStyle: AppTextStyle.whiteS14,
        labelColor: Colors.white,
        unselectedLabelColor: AppColors.textWhite,
        indicator: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: const BorderRadius.all(Radius.circular(18)),
          boxShadow: AppShadow.boxShadow,
        ),
        indicatorWeight: 0,
      ),
    );
  }

  List<Widget> buildTabItems() {
    List<Widget> items = [];
    for (int i = 0; i < (tabItems).length; i++) {
      items.add(buildTabItem(tabItems[i], i));
    }
    return items;
  }

  Widget buildTabItem(String title, int index) {
    return Text(
      title,
    );
  }
}
