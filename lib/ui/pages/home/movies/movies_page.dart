import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_dimens.dart';
import 'package:flutter_base/configs/app_configs.dart';
import 'package:flutter_base/models/entities/movie_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/models/enums/movie_category.dart';
import 'package:flutter_base/ui/pages/home/movies/movies_navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repositories/movie_repository.dart';
import 'movies_cubit.dart';
import 'movies_state.dart';
import 'widgets/loading_list_widget.dart';
import 'widgets/movie_widget.dart';

class MoviesPage extends StatelessWidget {
  final MovieCategory section;

  const MoviesPage({
    required this.section,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return MoviesCubit(
          navigator: MoviesNavigator(context: context),
          movieRepo: context.read<MovieRepository>(),
        );
      },
      child: MoviesChildPage(section),
    );
  }
}

class MoviesChildPage extends StatefulWidget {
  final MovieCategory section;

  const MoviesChildPage(this.section, {Key? key}) : super(key: key);

  @override
  State<MoviesChildPage> createState() => _MoviesChildPageState();
}

class _MoviesChildPageState extends State<MoviesChildPage>
    with AutomaticKeepAliveClientMixin {
  late MoviesCubit _cubit;

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _cubit = context.read<MoviesCubit>();
    _cubit.fetchInitialMovies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildContentWidget();
  }

  Widget buildContentWidget() {
    return BlocBuilder<MoviesCubit, MoviesState>(
      bloc: _cubit,
      builder: (context, state) {
        if (state.loadMovieStatus == LoadStatus.loading) {
          return _buildLoadingList();
        } else if (state.loadMovieStatus == LoadStatus.failure) {
          return Container();
        } else {
          return _buildSuccessList(
            state.movies,
          );
        }
      },
    );
  }

  Widget _buildLoadingList() {
    return const LoadingMoviesWidget();
  }

  Widget _buildSuccessList(List<MovieEntity> items) {
    return RefreshIndicator(
      onRefresh: _onRefreshData,
      child: GridView.builder(
        controller: _scrollController,
        padding:
            const EdgeInsets.symmetric(horizontal: AppDimens.paddingNormal),
        itemBuilder: (context, index) {
          final item = items[index];
          return MovieWidget(
            movie: item,
            onPressed: () {
              _cubit.navigator.openMovieDetail(id: item.id ?? 0);
            },
          );
        },
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppDimens.paddingNormal,
          mainAxisSpacing: AppDimens.paddingNormal,
          childAspectRatio: 3 / 4,
        ),
        // controller: _scrollController,
      ),
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= AppConfigs.scrollThreshold) {
      _cubit.fetchNextMovies();
    }
  }

  Future<void> _onRefreshData() async {
    _cubit.fetchInitialMovies();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
