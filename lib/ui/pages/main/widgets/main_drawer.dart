import 'package:flutter/material.dart';
import 'package:flutter_base/ui/pages/main/widgets/theme_mode_widget.dart';
import 'package:flutter_base/ui/pages/profile/widgets/menu_header_widget.dart';
import 'package:flutter_base/ui/pages/profile/widgets/menu_item_widget.dart';
import 'package:flutter_base/ui/pages/setting/setting_page.dart';
import 'package:get/get.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  // DrawerHeader(
                  //   child: Row(),
                  // ),
                  const MenuHeaderWidget(title: "Lists"),
                  // MenuItemWidget(title: "Watchlist"),
                  const MenuItemWidget(title: "History"),
                  // MenuItemWidget(title: "Collection"),
                  // MenuItemWidget(title: "Personal Lists"),
                  // MenuItemWidget(title: "Reminders"),
                  // MenuItemWidget(title: "Hidden Items"),
                  const MenuHeaderWidget(title: "Settings"),
                  // MenuItemWidget(title: "Go Premium"),
                  MenuItemWidget(
                    title: "Settings",
                    onPressed: () {
                      Get.to(() => const SettingPage());
                    },
                  ),
                  const MenuItemWidget(title: "Help & feedback"),
                  const MenuItemWidget(title: "About"),
                ],
              ),
            ),
            const ThemeModeWidget(),
          ],
        ),
      ),
    );
  }
}
