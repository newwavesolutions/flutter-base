import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_dimens.dart';
import 'package:flutter_base/models/entities/movie_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/ui/pages/movie_detail/movie_detail_view.dart';
import 'package:flutter_base/ui/pages/tab_home/enums/home_section.dart';
import 'package:flutter_base/ui/pages/tab_home/movies_section/widgets/loading_list_widget.dart';
import 'package:flutter_base/ui/pages/tab_home/movies_section/widgets/movie_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../repositories/movie_repository.dart';
import 'movies_section_cubit.dart';
import 'movies_section_state.dart';

class MoviesSectionPage extends StatefulWidget {
  final HomeSection section;

  const MoviesSectionPage(this.section, {Key? key}) : super(key: key);

  @override
  State<MoviesSectionPage> createState() => _MoviesSectionPageState();
}

class _MoviesSectionPageState extends State<MoviesSectionPage> {
  late MoviesSectionCubit _cubit;

  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    final movieRepo = RepositoryProvider.of<MovieRepository>(context);
    _cubit = MoviesSectionCubit(
      movieRepo: movieRepo,
    );
    _cubit.fetchInitialMovies();
  }

  @override
  Widget build(BuildContext context) {
    return buildContentWidget();
  }

  Widget buildContentWidget() {
    return BlocBuilder<MoviesSectionCubit, MoviesSectionState>(
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
    return const LoadingListWidget();
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
              Get.to(const MovieDetailPage());
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
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _cubit.fetchNextMovies();
    }
  }

  Future<void> _onRefreshData() async {
    _cubit.fetchInitialMovies();
  }
}
