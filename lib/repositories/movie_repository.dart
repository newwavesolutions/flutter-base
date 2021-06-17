import 'package:flutter/cupertino.dart';
import 'package:flutter_base/configs/app_config.dart';
import 'package:flutter_base/models/entities/movie_entity.dart';
import 'package:flutter_base/models/responses/array_response.dart';
import 'package:flutter_base/network/api_client.dart';

abstract class MovieRepository {
  Future<ArrayResponse<MovieEntity>> getMovies({@required int page});

  Future<MovieEntity> getMovie(int id);
}

class MovieRepositoryImpl extends MovieRepository {
  ApiClient _apiClient;

  MovieRepositoryImpl(ApiClient client) {
    _apiClient = client;
  }

  @override
  Future<MovieEntity> getMovie(int id) {
    // TODO: implement getMovie
    throw UnimplementedError();
  }

  @override
  Future<ArrayResponse<MovieEntity>> getMovies({@required int page}) async {
    try {
      return _apiClient.getMovies(MovieAPIConfig.APIKey, page);
    } catch (e) {
      throw e;
    }
  }
}
