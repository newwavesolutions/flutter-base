import 'package:flutter/material.dart';
import 'package:flutter_base/ui/pages/tab_home/enums/home_section.dart';
import 'package:flutter_base/ui/pages/tab_home/movies_section/movies_section_view.dart';
import 'package:flutter_base/ui/pages/tab_home/widgets/home_app_bar.dart';

class HomeTabPage extends StatefulWidget {
  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
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
        child: RefreshIndicator(
          onRefresh: _onRefreshData,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTrendingMovies(),
                _buildTrendingTvShows(),
                _buildNowPlayingMovies(),
                _buildUpcomingMovies(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTrendingMovies() {
    return MoviesSectionPage(HomeSection.trendingMovies);
  }

  Widget _buildTrendingTvShows() {
    return MoviesSectionPage(HomeSection.trendingTvShows);
  }

  Widget _buildNowPlayingMovies() {
    return MoviesSectionPage(HomeSection.nowPlayingMovies);
  }

  Widget _buildUpcomingMovies() {
    return MoviesSectionPage(HomeSection.upcomingMovies);
  }

  Future<void> _onRefreshData() async {
    // _trendingMoviesCubit.fetchInitialMovies();
    // _trendingTvShowsCubit.fetchInitialMovies();
    // _nowPlayingMoviesCubit.fetchInitialMovies();
    // _upcomingMoviesCubit.fetchInitialMovies();
  }
}
