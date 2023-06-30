import 'package:flutter/cupertino.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/movie_repository.dart';
import 'package:flutter_base/ui/pages/home/movies/movies_navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesNavigator navigator;
  MovieRepository movieRepo;

  MoviesCubit({
    required this.navigator,
    required this.movieRepo,
  }) : super(const MoviesState());

  void fetchInitialMovies() async {
    emit(state.copyWith(loadMovieStatus: LoadStatus.loading));
    try {
      final result = await movieRepo.getMovies(page: 1);
      emit(state.copyWith(
        loadMovieStatus: LoadStatus.success,
        movies: result.results,
        page: result.page,
        totalPages: result.totalPages,
      ));
    } catch (e) {
      emit(state.copyWith(loadMovieStatus: LoadStatus.failure));
    }
  }

  void fetchNextMovies() async {
    if (state.page == state.totalPages) {
      return;
    }
    if (state.loadMovieStatus == LoadStatus.loading) {
      return;
    }
    emit(state.copyWith(
      loadMovieStatus: LoadStatus.loadingMore,
    ));
    try {
      final result = await movieRepo.getMovies(page: state.page + 1);
      final resultList = state.movies..addAll(result.results);
      emit(state.copyWith(
          loadMovieStatus: LoadStatus.success,
          movies: resultList,
          page: result.page + 1,
          totalPages: result.totalPages));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
