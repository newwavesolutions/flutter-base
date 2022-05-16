import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/movie_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MovieRepository movieRepo;

  MoviesCubit({
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
    // if (state.page.value == state.totalPages.value) {
    //   return;
    // }
    // if (state.loadMovieStatus.value != LoadStatus.success) {
    //   return;
    // }
    // state.loadMovieStatus.value = LoadStatus.loadingMore;
    // try {
    //   final result = await apiService.getMovies(page: state.page.value + 1);
    //   state.loadMovieStatus.value = LoadStatus.success;
    //   state.movies.value = result.results;
    //   state.page.value = state.page.value + result.page;
    //   state.page.value = result.page;
    //   state.totalPages.value = result.totalPages;
    // } catch (e) {
    //   state.loadMovieStatus.value = LoadStatus.success;
    // }
  }
}
