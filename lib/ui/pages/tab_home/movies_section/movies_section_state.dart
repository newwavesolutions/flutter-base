import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/entities/movie_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';

class MoviesSectionState extends Equatable {
  final LoadStatus loadMovieStatus;
  final List<MovieEntity> movies;
  final int page;
  final int totalResults;
  final int totalPages;

  MoviesSectionState({
    this.loadMovieStatus = LoadStatus.initial,
    this.movies = const [],
    this.page = 1,
    this.totalResults = 0,
    this.totalPages = 0,
  });

  bool get hasReachedMax {
    return page >= totalPages;
  }

  @override
  List<Object?> get props => [
        this.loadMovieStatus,
        this.movies,
        this.page,
        this.totalResults,
        this.totalPages,
      ];

  MoviesSectionState copyWith({
    LoadStatus? loadMovieStatus,
    List<MovieEntity>? movies,
    int? page,
    int? totalResults,
    int? totalPages,
  }) {
    return MoviesSectionState(
      loadMovieStatus: loadMovieStatus ?? this.loadMovieStatus,
      movies: movies ?? this.movies,
      page: page ?? this.page,
      totalResults: totalResults ?? this.totalResults,
      totalPages: totalPages ?? this.totalPages,
    );
  }
}
