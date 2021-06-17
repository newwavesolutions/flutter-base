part of 'movies_section_cubit.dart';

class MoviesSectionState extends Equatable {
  final LoadStatus loadMovieStatus;
  final List<MovieEntity> movies;
  final int page;
  final int totalResults;
  final int totalPages;

  MoviesSectionState({
    this.loadMovieStatus,
    this.movies = const [],
    this.page = 1,
    this.totalResults = 0,
    this.totalPages = 1,
  });

  MoviesSectionState copyWith({
    LoadStatus loadMovieStatus,
    List<MovieEntity> movies,
    int page,
    int totalResults,
    int totalPages,
  }) {
    return new MoviesSectionState(
      loadMovieStatus: loadMovieStatus ?? this.loadMovieStatus,
      movies: movies ?? this.movies,
      page: page ?? this.page,
      totalResults: totalResults ?? this.totalResults,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  @override
  List<Object> get props => [
        this.loadMovieStatus,
        this.movies,
        this.page,
        this.totalResults,
        this.totalPages,
      ];

  bool get hasReachedMax {
    return page >= totalPages;
  }
}
