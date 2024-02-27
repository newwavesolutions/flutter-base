import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_dimens.dart';
import 'package:flutter_base/global_blocs/user_info/user_info_cubit.dart';
import 'package:flutter_base/models/entities/user/user_entity.dart';
import 'package:flutter_base/models/enums/movie_category.dart';
import 'package:flutter_base/ui/pages/home/home_cubit.dart';
import 'package:flutter_base/ui/pages/home/home_navigator.dart';
import 'package:flutter_base/ui/widgets/tabs/app_tab_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'movies/movies_page.dart';
import 'widgets/home_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return HomeCubit(navigator: HomeNavigator(context: context));
      },
      child: const HomeChildPage(),
    );
  }
}

class HomeChildPage extends StatefulWidget {
  const HomeChildPage({super.key});

  @override
  State<HomeChildPage> createState() => _HomeChildPageState();
}

class _HomeChildPageState extends State<HomeChildPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  late TabController _tapBarController;

  @override
  void initState() {
    super.initState();
    context.read<UserInfoCubit>().updateUser(UserEntity.mockData());
    _tapBarController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: const HomeAppBar(),
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
}
