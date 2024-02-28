import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/movie_repository.dart';
import 'package:flutter_base/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_navigator.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeNavigator navigator;
  final MovieRepository movieRepo;

  HomeCubit({
    required this.navigator,
    required this.movieRepo,
  }) : super(const HomeState());

  void fetchInitialMovies() async {
    if (state.loadMovieStatus == LoadStatus.loading) {
      return;
    }
    emit(state.copyWith(loadMovieStatus: LoadStatus.loading));
    await Future.delayed(const Duration(seconds: 1));
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
    await Future.delayed(const Duration(seconds: 1));
    try {
      final result = await movieRepo.getMovies(page: state.page + 1);
      final resultList = state.movies..addAll(result.results);
      emit(state.copyWith(
          loadMovieStatus: LoadStatus.success,
          movies: resultList,
          page: result.page + 1,
          totalPages: result.totalPages));
    } catch (e) {
      logger.i(e.toString());
    }
  }
}
