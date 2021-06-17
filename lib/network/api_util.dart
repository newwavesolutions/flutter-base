import 'package:dio/dio.dart';
import 'package:flutter_base/configs/app_config.dart';
import 'package:flutter_base/network/api_client.dart';

import 'api_interceptors.dart';

class ApiUtil {
  ApiClient apiClient;
  Dio dio;

  ApiUtil._privateConstructor() {
    dio = Dio();
    dio.options.connectTimeout = 30000;
    dio.interceptors.add(ApiInterceptors());
    apiClient = ApiClient(dio, baseUrl: AppConfig.baseUrl);
  }

  static final ApiUtil instance = ApiUtil._privateConstructor();
}
