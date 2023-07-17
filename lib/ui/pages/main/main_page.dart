import 'package:flutter/material.dart';
import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/blocs/setting/app_setting_cubit.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/router/route_config.dart';
import 'package:flutter_base/ui/pages/home/home_page.dart';
import 'package:flutter_base/ui/pages/main/main_cubit.dart';
import 'package:flutter_base/ui/pages/movie_list/movie_list_page.dart';
import 'package:flutter_base/ui/pages/profile/profile_page.dart';
import 'package:flutter_base/ui/pages/widget_list/widget_list_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'main_state.dart';
import 'main_tab.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainCubit>(
      create: (BuildContext context) => MainCubit(),
      child: const _MainPage(),
    );
  }
}

class _MainPage extends StatefulWidget {
  const _MainPage({Key? key}) : super(key: key);

  @override
  State<_MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<_MainPage> {
  ///PageView page
  late List<Widget> pageList;
  late PageController pageController;

  final tabs = [
    MainTab.home,
    MainTab.movies,
    MainTab.widgets,
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
      const MovieListPage(),
      const WidgetListPage(),
      const ProfilePage(),
    ];
    //Page controller
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AppCubit, AppState>(
          listenWhen: (prev, current) {
            return prev.signOutStatus != current.signOutStatus &&
                current.signOutStatus == LoadStatus.success;
          },
          listener: (context, state) {
            BlocProvider.of<AppSettingCubit>(context).resetSetting();
            GoRouter.of(context).pushReplacementNamed(AppRouter.signIn);
          },
        )
      ],
      child: Scaffold(
        body: _buildPageView(),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  Widget _buildPageView() {
    return PageView(
      controller: pageController,
      children: pageList,
      onPageChanged: (index) {
        _cubit.switchTap(index);
      },
    );
  }

  Widget _buildBottomNavigationBar() {
    final theme = Theme.of(context);
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
          backgroundColor: theme.appBarTheme.backgroundColor,
          elevation: 8,
          type: BottomNavigationBarType.fixed,
          currentIndex: state.selectedIndex,
          unselectedItemColor: Colors.grey,
          selectedItemColor: theme.indicatorColor,
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
