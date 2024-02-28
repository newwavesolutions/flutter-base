import 'package:flutter/material.dart';
import 'package:flutter_base/ui/pages/home/home_page.dart';
import 'package:flutter_base/ui/pages/notification/notification_list/notification_list_page.dart';
import 'package:flutter_base/ui/pages/profile/profile_page.dart';

enum MainTab {
  home,
  notification,
  profile,
}

extension MainTabExtension on MainTab {
  Widget get page {
    switch (this) {
      case MainTab.home:
        return const HomePage();
      case MainTab.notification:
        return const NotificationListPage();
      case MainTab.profile:
        return const ProfilePage();
    }
  }

  BottomNavigationBarItem get tab {
    switch (this) {
      case MainTab.home:
        return const BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: "Home",
        );
      case MainTab.notification:
        return const BottomNavigationBarItem(
          icon: Icon(Icons.notifications_outlined),
          label: "Notifications",
        );
      case MainTab.profile:
        return const BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: "Profile",
        );
    }
  }

  String get title {
    switch (this) {
      case MainTab.home:
        return 'Home';
      case MainTab.notification:
        return 'Notification';
      case MainTab.profile:
        return 'Profile';
    }
  }
}
