import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_base/models/entities/movie_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/movie_repository.dart';
import 'package:flutter_base/ui/commons/error_page.dart';
import 'package:flutter_base/ui/pages/movie_detail/movie_detail_navigator.dart';
import 'package:flutter_base/ui/widgets/images/app_cache_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'movie_detail_cubit.dart';
import 'widgets/loading_movie_detail_widget.dart';

class MovieDetailArguments {
  final int id;

  MovieDetailArguments({
    required this.id,
  });
}

class MovieDetailPage extends StatelessWidget {
  final MovieDetailArguments arguments;

  const MovieDetailPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final movieRepo = RepositoryProvider.of<MovieRepository>(context);
        return MovieDetailCubit(
          navigator: MovieDetailNavigator(context: context),
          movieRepo: movieRepo,
        );
      },
      child: MovieDetailChildPage(
        id: arguments.id,
      ),
    );
  }
}

class MovieDetailChildPage extends StatefulWidget {
  final int id;

  const MovieDetailChildPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<MovieDetailChildPage> createState() => _MovieDetailChildPageState();
}

class _MovieDetailChildPageState extends State<MovieDetailChildPage> {
  late MovieDetailCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.fetchInitialMovies(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MovieDetail'),
        elevation: 0,
      ),
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {
    return RefreshIndicator(
      onRefresh: _onRefreshData,
      child: BlocBuilder<MovieDetailCubit, MovieDetailState>(
        buildWhen: (previous, current) =>
            previous.loadMovieStatus != current.loadMovieStatus,
        builder: (context, state) {
          return state.loadMovieStatus == LoadStatus.loading
              ? _buildLoadingList()
              : (state.loadMovieStatus == LoadStatus.failure)
                  ? ErrorMovieDetailWidget(
                      onPressed: _onRefreshData,
                    )
                  : SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: _buildDetailMovieSuccessWidget(
                        movieEntity: state.movieEntity ?? MovieEntity(),
                      ),
                    );
        },
      ),
    );
  }

  Widget _buildDetailMovieSuccessWidget({
    required MovieEntity movieEntity,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            List<String> listPosterPath = [
              movieEntity.posterPathUrl,
              movieEntity.posterPathUrl,
            ];
            _cubit.navigator.openPhotoView(photoUrls: listPosterPath);
          },
          child: AppCacheImage(
            url: movieEntity.posterPathUrl,
            width: double.infinity,
            height: 500,
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          movieEntity.originalTitle ?? '',
          style: AppTextStyle.blackS18W800,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Text(
            movieEntity.overview ?? '',
            style: AppTextStyle.blackS18,
            textAlign: TextAlign.start,
          ),
        )
      ],
    );
  }

  Widget _buildLoadingList() {
    return const LoadingMovieDetailWidget();
  }

  Future<void> _onRefreshData() async {
    _cubit.fetchInitialMovies(id: widget.id);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
