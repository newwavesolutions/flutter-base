import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/entities/movie_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';

class HomeState extends Equatable {
  final LoadStatus loadTrendingStatus;
  final List<MovieEntity> trendingMovies;
  final LoadStatus loadUpcomingStatus;
  final List<MovieEntity> upcomingMovies;

  const HomeState({
    this.loadTrendingStatus = LoadStatus.initial,
    this.loadUpcomingStatus = LoadStatus.initial,
    this.trendingMovies = const [],
    this.upcomingMovies = const [],
  });

  @override
  List<Object?> get props => [
        loadTrendingStatus,
        loadUpcomingStatus,
        trendingMovies,
        upcomingMovies,
      ];
}
