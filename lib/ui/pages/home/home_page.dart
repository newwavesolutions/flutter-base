import 'package:flutter/material.dart';
import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/common/app_dimens.dart';
import 'package:flutter_base/models/enums/movie_category.dart';
import 'package:flutter_base/ui/pages/home/home_cubit.dart';
import 'package:flutter_base/ui/pages/home/home_navigator.dart';
import 'package:flutter_base/ui/pages/home/home_state.dart';
import 'package:flutter_base/ui/pages/notification/notification_list/notification_list_page.dart';
import 'package:flutter_base/ui/widgets/images/app_circle_avatar.dart';
import 'package:flutter_base/ui/widgets/tabs/app_tab_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'movies/movies_page.dart';
import 'widgets/home_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final appCubit = RepositoryProvider.of<AppCubit>(context);
        return HomeCubit(appCubit: appCubit);
      },
      child: const HomeChildPage(),
    );
  }
}

class HomeChildPage extends StatefulWidget {
  const HomeChildPage({Key? key}) : super(key: key);

  @override
  State<HomeChildPage> createState() => _HomeChildPageState();
}

class _HomeChildPageState extends State<HomeChildPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  late TabController _tapBarController;
  late HomeCubit _homeCubit;
  late HomeNavigator navigator;

  @override
  void initState() {
    super.initState();
    _homeCubit = BlocProvider.of(context);
    _homeCubit.getAvatar();
    _tapBarController = TabController(length: 2, vsync: this);
    navigator = HomeNavigator(context: context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: HomeAppBar(
        avatar: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return AppCircleAvatar(
              url: state.urlAvatar ?? '',
              size: 40,
            );
          },
        ),
        onNotificationPressed: _openNotificationList,
        onAvatarPressed: () {
          navigator.openProfile();
        },
      ),
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
