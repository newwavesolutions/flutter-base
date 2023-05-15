import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_dimens.dart';
import 'package:flutter_base/models/enums/movie_category.dart';
import 'package:flutter_base/ui/pages/notification/notification_list/notification_list_page.dart';
import 'package:flutter_base/ui/widgets/tabs/app_tab_bar.dart';

import 'movies/movies_page.dart';
import 'widgets/home_app_bar.dart';

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

  @override
  void initState() {
    super.initState();
    _tapBarController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: HomeAppBar(
        //Todo
        // avatarUrl: authService.user.value?.avatarUrl ?? "",
        onNotificationPressed: _openNotificationList,
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
