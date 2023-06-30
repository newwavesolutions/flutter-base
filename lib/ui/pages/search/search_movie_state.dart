part of 'search_movie_cubit.dart';

class SearchState extends Equatable {
  final LoadStatus searchMovieStatus;
  final List<MovieEntity>? movies;

  const SearchState({
    this.searchMovieStatus = LoadStatus.initial,
    this.movies,
  });

  @override
  List<Object?> get props => [
        searchMovieStatus,
        movies,
      ];

  SearchState copyWith({
    LoadStatus? searchMovieStatus,
    List<MovieEntity>? movies,
  }) {
    return SearchState(
      searchMovieStatus: searchMovieStatus ?? this.searchMovieStatus,
      movies: movies ?? this.movies,
    );
  }
}
