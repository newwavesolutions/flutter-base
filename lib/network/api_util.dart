import 'package:dio/dio.dart';
import 'package:flutter_base/configs/app_configs.dart';
import 'package:flutter_base/models/entities/token_entity.dart';
import 'package:flutter_base/models/response/object_response.dart';
import 'package:flutter_base/utils/logger.dart';

import 'api_client.dart';
import 'api_interceptors.dart';

class ApiUtil {
  static Dio? dio;

  static Dio getDio() {
    if (dio == null) {
      dio = Dio();
      dio!.options.connectTimeout = const Duration(milliseconds: 60000);
      dio!.interceptors.add(ApiInterceptors());
    }
    return dio!;
  }

  static ApiClient get apiClient {
    final apiClient = ApiClient(getDio(), baseUrl: AppConfigs.baseUrl);
    return apiClient;
  }

  static ApiClient get mocKyApiClient {
    final apiClient = ApiClient(getDio(), baseUrl: AppConfigs.mocKyBaseUrl);
    return apiClient;
  }

  static Future<TokenEntity?> onRefreshToken(String? token) async {
    if (token == null) return null;
    final dio = Dio();
    dio.options.connectTimeout = const Duration(milliseconds: 60000);
    dio.options.headers['Authorization'] = "Bearer $token";
    dio.options.headers['connection'] = "keep-alive";
    final res = await dio.get('${AppConfigs.mocKyBaseUrl}/refresh-token');
    logger.log(
      "✈️ REQUEST[GET] => PATH: ${AppConfigs.mocKyBaseUrl}/refresh-token \n Token: ${dio.options.headers}",
      printFullText: true,
    );

    final value = res.data == null
        ? null
        : ObjectResponse<TokenEntity>.fromJson(
            res.data!,
            (json) => TokenEntity.fromJson(json as Map<String, dynamic>),
          );
    if (value != null && value.data != null) {
      logger.d(
          '------------------------Get New AccessToken---------------------------\n');
      logger.log(
        'AccessToken token: ${value.data?.accessToken}',
        printFullText: true,
      );
      return value.data;
    }
    return null;
  }
}
