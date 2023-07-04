import 'package:dio/dio.dart';
import 'package:flutter_base/models/response/array_response.dart';
import 'package:retrofit/retrofit.dart';

import '../models/entities/movie_entity.dart';
import '../models/entities/notification/notification_entity.dart';
import '../models/entities/token_entity.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  ///User
  @POST("/login")
  Future<TokenEntity> authLogin(@Body() Map<String, dynamic> body);

  @POST("/logout")
  Future<dynamic> signOut(@Body() Map<String, dynamic> body);

  /// Notification
  @GET("/v3/ca940623-8c6c-45e9-86b8-e0156be45290")
  Future<ArrayResponse<NotificationEntity>> getNotifications(
    @Query('page') int page,
  );

  @POST("/v3/ca940623-8c6c-45e9-86b8-e0156be45290")
  Future<void> markAllNotificationAsRead();

  @POST("/v3/ca940623-8c6c-45e9-86b8-e0156be45290")
  Future<void> markNotificationAsRead();

  /// Movie
  @GET("/3/discover/movie")
  Future<ArrayResponse<MovieEntity>> getMovies(
    @Query('api_key') String apiKey,
    @Query('page') int page,
  );

  @GET("/3/movie/{id}")
  Future<MovieEntity> getDetailMovie(
    @Query('api_key') String apiKey,
    @Path('id') int id,
  );
}
