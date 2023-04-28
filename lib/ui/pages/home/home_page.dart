import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_dimens.dart';
import 'package:flutter_base/models/enums/movie_category.dart';
import 'package:flutter_base/ui/pages/home/home_cubit.dart';
import 'package:flutter_base/ui/widgets/tabs/app_tab_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'movies/movies_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return HomeCubit();
      },
      child: const HomePageChild(),
    );
  }
}

class HomePageChild extends StatefulWidget {
  const HomePageChild({Key? key}) : super(key: key);

  @override
  State<HomePageChild> createState() => _HomePageChildState();
}

class _HomePageChildState extends State<HomePageChild>
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
    return SafeArea(
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
    );
  }

  Widget _buildTrendingMovies() {
    return const MoviesPage(section: MovieCategory.trending);
  }

  Widget _buildUpcomingMovies() {
    return const MoviesPage(section: MovieCategory.upcoming);
  }
}
