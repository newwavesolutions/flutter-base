import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/entities/movie_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/movie_repository.dart';
import 'package:flutter_base/ui/pages/movie_detail/movie_detail_navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailNavigator navigator;
  MovieRepository movieRepo;

  MovieDetailCubit({
    required this.navigator,
    required this.movieRepo,
  }) : super(const MovieDetailState());

  Future<void> fetchInitialMovies({required int id}) async {
    emit(
      state.copyWith(loadMovieStatus: LoadStatus.loading),
    );
    try {
      final result = await movieRepo.getDetailMovie(id: id);
      if (result != null) {
        Future.delayed(const Duration(seconds: 3), () {
          emit(
            state.copyWith(
              movieEntity: result,
              loadMovieStatus: LoadStatus.success,
            ),
          );
        });
      }
    } catch (e) {
      Future.delayed(const Duration(seconds: 3), () {
        emit(
          state.copyWith(loadMovieStatus: LoadStatus.failure),
        );
      });
    }
  }
}
