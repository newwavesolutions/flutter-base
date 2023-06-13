part of 'movie_list_cubit.dart';

class MovieListState extends Equatable {
  final LoadStatus loadDataStatus;
  final List<MovieIsarEntity>? listMovie;

  const MovieListState(
      {this.loadDataStatus = LoadStatus.initial, this.listMovie});

  @override
  List<Object?> get props => [
        loadDataStatus,
        listMovie,
      ];

  MovieListState copyWith({
    LoadStatus? loadDataStatus,
    final List<MovieIsarEntity>? listMovie,
  }) {
    return MovieListState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      listMovie: listMovie ?? this.listMovie,
    );
  }
}
