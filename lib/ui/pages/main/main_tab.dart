import 'package:flutter/material.dart';
import 'package:flutter_base/ui/pages/home/home_page.dart';
import 'package:flutter_base/ui/pages/movie_list/movie_list_page.dart';
import 'package:flutter_base/ui/pages/profile/profile_page.dart';
import 'package:flutter_base/ui/pages/widget_list/widget_list_page.dart';

enum MainTab {
  home,
  movies,
  widgets,
  profile,
}

extension MainTabExtension on MainTab {
  Widget get page {
    switch (this) {
      case MainTab.home:
        return const HomePage();
      case MainTab.movies:
        return const MovieListPage();
      case MainTab.widgets:
        return const WidgetListPage();
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
      case MainTab.movies:
        return const BottomNavigationBarItem(
          icon: Icon(Icons.movie_creation_outlined),
          label: "Movies",
        );
      case MainTab.widgets:
        return const BottomNavigationBarItem(
          icon: Icon(Icons.widgets_outlined),
          label: "Widgets",
        );
      case MainTab.profile:
        return const BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_rounded),
          label: "Profile",
        );
    }
  }

  String get title {
    switch (this) {
      case MainTab.home:
        return 'Home';
      case MainTab.movies:
        return 'Movies';
      case MainTab.widgets:
        return 'Widgets';
      case MainTab.profile:
        return 'Profile';
    }
  }
}
