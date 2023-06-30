import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/entities/movie_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/movie_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_movie_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final MovieRepository movieRepo;

  SearchCubit({
    required this.movieRepo,
  }) : super(const SearchState());

  Future<void> searchMovies({
    required String searchText,
  }) async {
    emit(state.copyWith(
      searchMovieStatus: LoadStatus.loading,
    ));
    try {
      final result = await movieRepo.searchMovies(searchText: searchText);
      Future.delayed(const Duration(seconds: 1), () {
        if (result.results.isNotEmpty) {
          emit(
            state.copyWith(
              movies: result.results,
              searchMovieStatus: LoadStatus.success,
            ),
          );
        } else {
          emit(state.copyWith(
            searchMovieStatus: LoadStatus.failure,
          ));
        }
      });
    } catch (e) {
      emit(state.copyWith(
        searchMovieStatus: LoadStatus.failure,
      ));
    }
  }

  void cleanSearch() {
    emit(state.copyWith(
      movies: [],
      searchMovieStatus: LoadStatus.initial,
    ));
  }
}
