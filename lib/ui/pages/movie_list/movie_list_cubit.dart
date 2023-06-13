import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/entities/movie_isar_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/movie_isar_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_list_state.dart';

class MovieListCubit extends Cubit<MovieListState> {
  final MovieIsarRepository movieIsarRepository;

  MovieListCubit({
    required this.movieIsarRepository,
  }) : super(const MovieListState());

  Future<void> getData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.loading));
    try {
      List<MovieIsarEntity>? listMovie = await movieIsarRepository.getMovie();
      emit(
        state.copyWith(
          loadDataStatus: LoadStatus.success,
          listMovie: listMovie,
        ),
      );
    } catch (e) {
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  Future<void> addMovie() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.loading));
    try {
      MovieIsarEntity isarEntity = MovieIsarEntity(
        name: 'hung',
        star: "5",
      );
      await movieIsarRepository.createMovie(isarEntity: isarEntity);
      emit(state.copyWith(loadDataStatus: LoadStatus.success));
    } catch (e) {
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }
}
