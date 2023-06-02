import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_vectors.dart';
import 'package:flutter_base/ui/pages/home/home_page.dart';
import 'package:flutter_base/ui/pages/main/custom_bottom_nav_item.dart';
import 'package:flutter_base/ui/pages/movie_list/movie_list_page.dart';
import 'package:flutter_base/ui/pages/profile/profile_page.dart';
import 'package:flutter_base/ui/pages/widget_list/widget_list_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

int indexSelected = 0;

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

  CustomBottomNavigationItem get tab {
    switch (this) {
      case MainTab.home:
        return CustomBottomNavigationItem(
          icon: SvgPicture.asset(
            AppVectors.icHomeBottomNavigator,
            width: 24,
            height: 24,
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
              (indexSelected == 0) ? Colors.red : Colors.black,
              BlendMode.srcIn,
            ),
          ),
          label: "Home",
          isActive: indexSelected == 0,
        );
      case MainTab.movies:
        return CustomBottomNavigationItem(
          icon: SvgPicture.asset(
            AppVectors.icMovieBottomNavigator,
            width: 24,
            height: 24,
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
              (indexSelected == 1) ? Colors.red : Colors.black,
              BlendMode.srcIn,
            ),
          ),
          label: "Movies",
          isActive: indexSelected == 1,
        );
      case MainTab.widgets:
        return CustomBottomNavigationItem(
          icon: SvgPicture.asset(
            AppVectors.icOutlineBottomNavigator,
            width: 24,
            height: 24,
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
              (indexSelected == 2) ? Colors.red : Colors.black,
              BlendMode.srcIn,
            ),
          ),
          label: "Widgets",
          isActive: indexSelected == 2,
        );
      case MainTab.profile:
        return CustomBottomNavigationItem(
          icon: SvgPicture.asset(
            AppVectors.icPersonBottomNavigator,
            width: 24,
            height: 24,
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
              (indexSelected == 3) ? Colors.red : Colors.black,
              BlendMode.srcIn,
            ),
          ),
          label: "Profile",
          isActive: indexSelected == 2,
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
