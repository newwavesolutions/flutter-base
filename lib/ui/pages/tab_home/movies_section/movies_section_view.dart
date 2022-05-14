import 'package:flutter/material.dart';
import 'package:flutter_base/models/entities/movie_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/ui/pages/movie_detail/movie_detail_view.dart';
import 'package:flutter_base/ui/pages/tab_home/enums/home_section.dart';
import 'package:flutter_base/ui/pages/tab_home/movies_section/widgets/loading_list_widget.dart';
import 'package:flutter_base/ui/pages/tab_home/movies_section/widgets/movie_widget.dart';
import 'package:flutter_base/ui/widgets/loading_more_row_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../repositories/movie_repository.dart';
import 'movies_section_cubit.dart';
import 'movies_section_state.dart';

class MoviesSectionPage extends StatefulWidget {
  final HomeSection section;

  MoviesSectionPage(this.section);

  @override
  _MoviesSectionPageState createState() => _MoviesSectionPageState();
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
    final theme = Theme.of(context);
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${widget.section.title}",
                  style: theme.textTheme.headline6,
                ),
                SizedBox(width: 10),
                Text(
                  "${widget.section.typeName}",
                  style: theme.textTheme.subtitle2,
                )
              ],
            ),
          ),
          Container(
            height: 160,
            width: double.infinity,
            child: buildContentWidget(),
          )
        ],
      ),
    );
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
            showLoadingMore: !state.hasReachedMax,
          );
        }
      },
    );
  }

  Widget _buildLoadingList() {
    return LoadingListWidget();
  }

  Widget _buildSuccessList(List<MovieEntity> items,
      {bool showLoadingMore = false}) {
    return Container(
      child: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(horizontal: 15),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index < items.length) {
            final item = items[index];
            return Container(
              height: 160,
              width: 82,
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: MovieWidget(
                movie: item,
                onPressed: () {
                  Get.to(MovieDetailPage());
                },
              ),
            );
          } else {
            return LoadingMoreRowWidget();
          }
        },
        itemCount: showLoadingMore ? items.length + 1 : items.length,
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
}
