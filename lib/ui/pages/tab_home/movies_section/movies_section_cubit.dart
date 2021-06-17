import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../models/entities/movie_entity.dart';
import '../../../../models/enums/load_status.dart';
import '../../../../repositories/movie_repository.dart';

part 'movies_section_state.dart';

class MoviesSectionCubit extends Cubit<MoviesSectionState> {
  MovieRepository repository;

  MoviesSectionCubit({this.repository}) : super(MoviesSectionState());

  void fetchInitialMovies() async {
    emit(state.copyWith(loadMovieStatus: LoadStatus.LOADING));
    try {
      final result = await repository.getMovies(page: 1);
      emit(state.copyWith(
        loadMovieStatus: LoadStatus.SUCCESS,
        movies: result.results,
        page: result.page,
        totalPages: result.totalPages,
      ));
    } catch (e) {
      emit(state.copyWith(loadMovieStatus: LoadStatus.FAILURE));
    }
  }

  void fetchNextMovies() async {
    if (state.page == state.totalPages) {
      return;
    }
    if (state.loadMovieStatus != LoadStatus.SUCCESS) {
      return;
    }
    emit(state.copyWith(loadMovieStatus: LoadStatus.LOADING_MORE));
    try {
      final result = await repository.getMovies(page: state.page + 1);
      emit(state.copyWith(
        loadMovieStatus: LoadStatus.SUCCESS,
        movies: state.movies + result.results,
        page: result.page,
        totalPages: result.totalPages,
      ));
    } catch (e) {
      emit(state.copyWith(loadMovieStatus: LoadStatus.SUCCESS));
    }
  }
}
