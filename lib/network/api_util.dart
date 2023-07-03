import 'package:dio/dio.dart';
import 'package:flutter_base/configs/app_configs.dart';
import 'package:flutter_base/models/entities/token_entity.dart';
import 'package:flutter_base/models/response/object_response.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_client.dart';
import 'api_interceptors.dart';

class ApiUtil {
  static Dio? dio;

  static Dio getDio() {
    if (dio == null) {
      dio = Dio();
      dio!.options.connectTimeout = const Duration(milliseconds: 60000);
      dio!.interceptors.add(ApiInterceptors());
      dio!.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        compact: false,
      ));
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
    dio.interceptors.add(PrettyDioLogger());
    final res = await dio.get('${AppConfigs.mocKyBaseUrl}/refresh-token');
    final value = res.data == null
        ? null
        : ObjectResponse<TokenEntity>.fromJson(
            res.data!,
            (json) => TokenEntity.fromJson(json as Map<String, dynamic>),
          );
    if (value != null && value.data != null) {
      return value.data;
    }
    return null;
  }
}
