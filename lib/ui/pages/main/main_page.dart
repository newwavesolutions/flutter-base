import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/commons/app_colors.dart';
import 'package:flutter_base/ui/pages/main/tab/main_tab.dart';
import 'package:flutter_base/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../commons/app_colors.dart';
import 'main_cubit.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  final _pageController = PageController(initialPage: 0, keepPage: true);

  final tabs = [
    MainTab.home,
    MainTab.discover,
    MainTab.tvShows,
    MainTab.watchlist,
    MainTab.profile,
  ];

  List<Widget> pages;

  MainCubit _cubit;

  @override
  void initState() {
    _cubit = MainCubit();
    super.initState();
    pages = tabs.map((e) => e.page).toList();

    _cubit.listen((state) {
      logger.d('Change tab1 ${state.currentTabIndex}');
      // _pageController.animateToPage(state.currentTabIndex,
      //     duration: Duration(milliseconds: 300), curve: Curves.ease);
      _pageController.jumpToPage(state.currentTabIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageView(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildPageView() {
    return PageView(
      // physics: NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: pages,
      onPageChanged: (index) {
        _cubit.changeTab(index);
      },
    );
  }

  Widget _buildBottomNavigationBar() {
    return BlocBuilder<MainCubit, MainState>(
      cubit: _cubit,
      buildWhen: (prev, current) {
        return prev.currentTabIndex != current.currentTabIndex;
      },
      builder: (context, state) {
        return BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: AppColors.backgroundTint,
          type: BottomNavigationBarType.fixed,
          currentIndex: state.currentTabIndex,
          unselectedItemColor: Colors.black54,
          selectedItemColor: AppColors.main,
          items: tabs.map((e) => e.tab).toList(),
          onTap: (index) {
            _cubit.changeTab(index);
          },
        );
      },
    );
  }
}
