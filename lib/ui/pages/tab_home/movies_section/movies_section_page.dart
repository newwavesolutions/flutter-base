import 'package:flutter/material.dart';
import 'package:flutter_base/ui/pages/tab_home/enums/home_section.dart';
import 'package:flutter_base/ui/pages/tab_home/movies_section/movies_section_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../commons/app_text_styles.dart';
import '../../../../models/entities/movie_entity.dart';
import '../../../../models/enums/load_status.dart';
import '../../../widgets/loading_more_row_widget.dart';
import 'widgets/loading_list_widget.dart';
import 'widgets/movie_widget.dart';

class MoviesSectionPage extends StatefulWidget {
  final HomeSection section;

  const MoviesSectionPage({this.section, Key key}) : super(key: key);

  @override
  _MoviesSectionPageState createState() => _MoviesSectionPageState();
}

class _MoviesSectionPageState extends State<MoviesSectionPage> {
  MoviesSectionCubit _cubit;

  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  @override
  void initState() {
    _cubit = BlocProvider.of<MoviesSectionCubit>(context);
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
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
                  style: AppTextStyle.whiteS18W800,
                ),
                SizedBox(width: 10),
                Text(
                  "${widget.section.typeName}",
                  style: AppTextStyle.greyS14,
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
      cubit: _cubit,
      buildWhen: (prev, current) {
        return prev.loadMovieStatus != current.loadMovieStatus;
      },
      builder: (context, state) {
        if (state.loadMovieStatus == LoadStatus.LOADING) {
          return _buildLoadingList();
        } else if (state.loadMovieStatus == LoadStatus.FAILURE) {
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

  Widget _buildSuccessList(List<MovieEntity> items, {bool showLoadingMore = false}) {
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
                onPressed: () {},
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
