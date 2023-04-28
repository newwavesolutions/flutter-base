import 'package:flutter/material.dart';

enum MainTab {
  home,
  discover,
  tvShows,
  search,
  profile,
}

extension MainTabExtension on MainTab {
  Widget get page {
    switch (this) {
      case MainTab.home:
      // return HomeTabPage();
      // return Container(color: Colors.red,);
      case MainTab.discover:
      // return DiscoverTabPage();
      case MainTab.tvShows:
      // return TvShowTabPage();
      case MainTab.search:
      // return WatchlistTabPage();
      case MainTab.profile:
      // return ProfileTabPage();
    }
    return Container();
  }

  BottomNavigationBarItem get tab {
    switch (this) {
      case MainTab.home:
        return BottomNavigationBarItem(
            icon: const Icon(Icons.home_rounded), label: title);
      case MainTab.discover:
        return BottomNavigationBarItem(
            icon: const Icon(Icons.explore_outlined), label: title);
      case MainTab.tvShows:
        return BottomNavigationBarItem(
            icon: const Icon(Icons.tv_rounded), label: title);
      case MainTab.search:
        return BottomNavigationBarItem(
            icon: const Icon(Icons.search), label: title);
      case MainTab.profile:
        return BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline_rounded), label: title);
    }
  }

  String get title {
    switch (this) {
      case MainTab.home:
        return 'Home';
      case MainTab.discover:
        return 'Notification';
      case MainTab.tvShows:
        return 'TV Shows';
      case MainTab.search:
        return 'Search';
      case MainTab.profile:
        return 'Profile';
    }
  }
}
