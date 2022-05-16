import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_dimens.dart';
import 'package:flutter_base/ui/pages/tab_home/enums/home_section.dart';
import 'package:flutter_base/ui/pages/tab_home/movies_section/movies_section_view.dart';
import 'package:flutter_base/ui/pages/tab_home/widgets/home_app_bar.dart';
import 'package:flutter_base/ui/widgets/tabs/app_tab_bar.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({Key? key}) : super(key: key);

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage>
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: HomeAppBar(
          //Todo
          // avatarUrl: authService.user.value?.avatarUrl ?? "",
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
    return const MoviesSectionPage(HomeSection.trendingMovies);
  }

  Widget _buildUpcomingMovies() {
    return const MoviesSectionPage(HomeSection.upcomingMovies);
  }
}
