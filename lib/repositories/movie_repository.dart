import 'package:flutter_base/configs/app_configs.dart';
import 'package:flutter_base/models/entities/movie_entity.dart';
import 'package:flutter_base/models/response/array_response.dart';
import 'package:flutter_base/network/api_client.dart';

abstract class MovieRepository {
  Future<ArrayResponse<MovieEntity>> getMovies({required int page});

  Future<MovieEntity?> getDetailMovie({required int id});
}

class MovieRepositoryImpl extends MovieRepository {
  ApiClient apiClient;

  MovieRepositoryImpl({required this.apiClient});

  @override
  Future<MovieEntity?> getDetailMovie({required int id}) {
    return apiClient.getDetailMovie(MovieAPIConfig.apiKey, id);
  }

  @override
  Future<ArrayResponse<MovieEntity>> getMovies({required int page}) async {
    return apiClient.getMovies(MovieAPIConfig.apiKey, page);
  }
}
