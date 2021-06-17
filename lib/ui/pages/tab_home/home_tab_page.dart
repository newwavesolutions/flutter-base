import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/commons/app_colors.dart';
import 'package:flutter_base/repositories/movie_repository.dart';
import 'package:flutter_base/ui/pages/tab_home/home_tab_cubit.dart';
import 'package:flutter_base/ui/pages/tab_home/movies_section/movies_section_cubit.dart';
import 'package:flutter_base/ui/pages/tab_home/movies_section/movies_section_page.dart';
import 'package:flutter_base/ui/pages/tab_home/widgets/home_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'enums/home_section.dart';

class HomeTabPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeTabPageState();
  }
}

class _HomeTabPageState extends State<HomeTabPage> with AutomaticKeepAliveClientMixin {
  HomeTabCubit _cubit;
  MoviesSectionCubit _trendingMoviesCubit;
  MoviesSectionCubit _trendingTvShowsCubit;
  MoviesSectionCubit _nowPlayingMoviesCubit;
  MoviesSectionCubit _upcomingMoviesCubit;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  StreamSubscription _messageSubscription;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    final repository = RepositoryProvider.of<MovieRepository>(context);
    _cubit = HomeTabCubit(repository: repository);
    //Todo: use array cubit is good
    _trendingMoviesCubit = MoviesSectionCubit(repository: repository);
    _trendingTvShowsCubit = MoviesSectionCubit(repository: repository);
    _nowPlayingMoviesCubit = MoviesSectionCubit(repository: repository);
    _upcomingMoviesCubit = MoviesSectionCubit(repository: repository);

    super.initState();
    _trendingMoviesCubit.fetchInitialMovies();
    _trendingTvShowsCubit.fetchInitialMovies();
    _nowPlayingMoviesCubit.fetchInitialMovies();
    _upcomingMoviesCubit.fetchInitialMovies();
    _messageSubscription = _cubit.messageController.stream.listen((event) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(event)));
    });
  }

  @override
  void dispose() {
    _messageSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _onRefreshData,
          child: SingleChildScrollView(
            child: Column(
              children: [
                HomeAppBar(),
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
    return BlocProvider(
      create: (context) => _trendingMoviesCubit,
      child: MoviesSectionPage(section: HomeSection.trendingMovies),
    );
  }

  Widget _buildTrendingTvShows() {
    return BlocProvider(
      create: (context) => _trendingTvShowsCubit,
      child: MoviesSectionPage(section: HomeSection.trendingTvShows),
    );
  }

  Widget _buildNowPlayingMovies() {
    return BlocProvider(
      create: (context) => _nowPlayingMoviesCubit,
      child: MoviesSectionPage(section: HomeSection.nowPlayingMovies),
    );
  }

  Widget _buildUpcomingMovies() {
    return BlocProvider(
      create: (context) => _upcomingMoviesCubit,
      child: MoviesSectionPage(section: HomeSection.upcomingMovies),
    );
  }

  Future<void> _onRefreshData() async {
    _trendingMoviesCubit.fetchInitialMovies();
    _trendingTvShowsCubit.fetchInitialMovies();
    _nowPlayingMoviesCubit.fetchInitialMovies();
    _upcomingMoviesCubit.fetchInitialMovies();
  }
}
