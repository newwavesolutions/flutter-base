part of 'movie_list_cubit.dart';

class MovieListState extends Equatable {
  final LoadStatus loadDataStatus;

  const MovieListState({
    this.loadDataStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
      ];

  MovieListState copyWith({
    LoadStatus? loadDataStatus,
  }) {
    return MovieListState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
    );
  }
}
