import 'package:json_annotation/json_annotation.dart';

part 'movie_entity.g.dart';

@JsonSerializable()
class MovieEntity {
  @JsonKey()
  int? id;
  @JsonKey()
  String? title;
  @JsonKey(name: 'poster_path')
  String? posterPath;
  @JsonKey(name: 'backdrop_path')
  String? backdropPath;
  @JsonKey(name: 'vote_average')
  double? voteAverage;
  @JsonKey(name: 'original_title')
  String? originalTitle;
  @JsonKey()
  String? overview;
  @JsonKey(name: 'release_date')
  String? releaseDate;

  MovieEntity({
    this.id,
    this.title,
    this.posterPath,
    this.backdropPath,
    this.voteAverage,
    this.originalTitle,
    this.overview,
    this.releaseDate,
  });

  factory MovieEntity.fromJson(Map<String, dynamic> json) =>
      _$MovieEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MovieEntityToJson(this);

  @JsonKey(includeFromJson: false, includeToJson: false)
  String get posterUrl {
    return 'https://image.tmdb.org/t/p/w185${posterPath ?? ""}';
  }

  String get posterPathUrl {
    return 'https://image.tmdb.org/t/p/original${posterPath ?? ""}';
  }
}
