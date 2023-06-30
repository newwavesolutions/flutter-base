part of 'movie_detail_cubit.dart';

class MovieDetailState extends Equatable {
  final LoadStatus loadMovieStatus;
  final MovieEntity? movieEntity;
  final int? id;

  const MovieDetailState({
    this.loadMovieStatus = LoadStatus.initial,
    this.movieEntity,
    this.id,
  });

  @override
  List<Object?> get props => [
        loadMovieStatus,
        movieEntity,
        id,
      ];

  MovieDetailState copyWith({
    LoadStatus? loadMovieStatus,
    MovieEntity? movieEntity,
    int? id,
  }) {
    return MovieDetailState(
      loadMovieStatus: loadMovieStatus ?? this.loadMovieStatus,
      movieEntity: movieEntity ?? this.movieEntity,
      id: id ?? this.id,
    );
  }
}
