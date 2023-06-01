import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_dimens.dart';
import 'package:flutter_base/common/app_images.dart';
import 'package:flutter_base/models/enums/movie_category.dart';
import 'package:flutter_base/models/enums/option_drawer.dart';
import 'package:flutter_base/ui/pages/home/home_cubit.dart';
import 'package:flutter_base/ui/pages/home/home_state.dart';
import 'package:flutter_base/ui/pages/notification/notification_list/notification_list_page.dart';
import 'package:flutter_base/ui/widgets/buttons/app_icon_button.dart';
import 'package:flutter_base/ui/widgets/tabs/app_tab_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'movies/movies_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  late TabController _tapBarController;
  late HomeCubit _cubit;

  @override
  void initState() {
    super.initState();
    _tapBarController = TabController(length: 2, vsync: this);
    _cubit = HomeCubit();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      // appBar: HomeAppBar(
      //   //Todo
      //   // avatarUrl: authService.user.value?.avatarUrl ?? "",
      //   onNotificationPressed: _openNotificationList,
      // ),
      appBar: AppBar(),
      drawer: _buildDrawWidget(),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppDimens.paddingNormal),
              child: AppTabBar(
                tabController: _tapBarController,
                tabItems: const [
                  "Trending",
                  "Upcoming",
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tapBarController,
                children: [
                  _buildTrendingMovies(),
                  _buildUpcomingMovies(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawWidget() {
    return Drawer(
      width: MediaQuery.of(context).size.width * 2 / 3,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Stack(
            children: [
              const SizedBox(
                width: 100,
                height: 175 + 34.5,
              ),
              Column(
                children: [
                  Image.asset(
                    AppImages.icDrawerHeader,
                    width: MediaQuery.of(context).size.width * 2 / 3,
                    height: 175,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
              Positioned(
                left: 10,
                bottom: 0,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(34.5),
                      child: Image.asset(
                        AppImages.icDrawerAvatar,
                        width: 69,
                        height: 69,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Long Admin"),
                        SizedBox(
                          height: 23,
                        ),
                        Text('+84123456hằng')
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          _buildOptionalDrawerWidget(),
        ],
      ),
    );
  }

  Widget _buildOptionalDrawerWidget() {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => previous.option != current.option,
      bloc: _cubit,
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(top: 25),
          child: ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemCount: OptionDrawer.values.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemBuilder: (context, index) {
              OptionDrawer optionDrawer = OptionDrawer.values[index];
              return _buildItemOptionalDrawerWidget(
                optionDrawer: optionDrawer,
                state: state,
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildItemOptionalDrawerWidget({
    required OptionDrawer optionDrawer,
    required HomeState state,
  }) {
    return AppIconButton(
      title: optionDrawer.name,
      leadingIcon: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Icon(
          optionDrawer.icon,
          color: state.option == optionDrawer ? Colors.red : Colors.grey,
        ),
      ),
      trailingIcon: SizedBox(
        child: Icon(
          state.option == optionDrawer
              ? Icons.arrow_forward_ios
              : Icons.arrow_back_ios,
          color: state.option == optionDrawer ? Colors.red : Colors.grey,
        ),
      ),
      onPressed: () {
        _cubit.changeOptionDrawer(
          option: optionDrawer,
          context: context,
        );
      },
    );
  }

  Widget _buildTrendingMovies() {
    return const MoviesPage(section: MovieCategory.trending);
  }

  Widget _buildUpcomingMovies() {
    return const MoviesPage(section: MovieCategory.upcoming);
  }

  void _openNotificationList() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const NotificationListPage()));
  }
}
