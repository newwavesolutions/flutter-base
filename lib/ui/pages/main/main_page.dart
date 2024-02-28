import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/ui/pages/home/home_page.dart';
import 'package:flutter_base/ui/pages/main/main_cubit.dart';
import 'package:flutter_base/ui/pages/notification/notification_list/notification_list_page.dart';
import 'package:flutter_base/ui/pages/profile/profile_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'main_state.dart';
import 'main_tab.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainCubit>(
      create: (BuildContext context) => MainCubit(),
      child: const _MainPage(),
    );
  }
}

class _MainPage extends StatefulWidget {
  const _MainPage();

  @override
  State<_MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<_MainPage> {
  ///PageView page
  late List<Widget> pageList;
  late PageController pageController;

  final tabs = [
    MainTab.home,
    MainTab.notification,
    MainTab.profile,
  ];

  late MainCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of(context);
    super.initState();
    //PageView page
    pageList = [
      const HomePage(),
      const NotificationListPage(),
      const ProfilePage(),
    ];
    //Page controller
    pageController = PageController();
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
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: (index) {
        _cubit.switchTap(index);
      },
      children: pageList,
    );
  }

  Widget _buildBottomNavigationBar() {
    return BlocConsumer<MainCubit, MainState>(
      bloc: _cubit,
      listenWhen: (prev, current) {
        return prev.selectedIndex != current.selectedIndex;
      },
      listener: (context, state) {
        pageController.jumpToPage(state.selectedIndex);
      },
      buildWhen: (prev, current) {
        return prev.selectedIndex != current.selectedIndex;
      },
      builder: (context, state) {
        return BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 8,
          type: BottomNavigationBarType.fixed,
          currentIndex: state.selectedIndex,
          unselectedItemColor: Colors.grey,
          selectedItemColor: AppColors.primary,
          items: tabs.map((e) => e.tab).toList(),
          onTap: (index) {
            _cubit.switchTap(index);
          },
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
