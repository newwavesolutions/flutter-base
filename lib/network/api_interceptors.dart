import 'dart:convert';

import 'package:dio/dio.dart';

import '../database/secure_storage.dart';
import '../global/global_event.dart';
import '../utils/logger.dart';

class ApiInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    final method = options?.method;
    final uri = options?.uri;
    final data = options?.data;

    final token = await SecureStorage.getInstance().getToken();
    if (token != null) {
      options?.headers['Authorization'] = 'Bearer ${token.accessToken}';
    }
    logger.log("\n\n--------------------------------------------------------------------------------------------------------");
    if (method == 'GET') {
      logger.log("✈️ REQUEST[$method] => PATH: $uri \n Token: ${options?.headers}", printFullText: true);
    } else {
      try {
        logger.log("✈️ REQUEST[$method] => PATH: $uri \n Token: ${token?.accessToken} \n DATA: ${jsonEncode(data)}", printFullText: true);
      } catch (e) {
        logger.log("✈️ REQUEST[$method] => PATH: $uri \n Token: ${token?.accessToken} \n DATA: $data", printFullText: true);
      }
    }
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    final statusCode = response?.statusCode;
    final uri = response?.request?.uri;
    final data = jsonEncode(response?.data);
    logger.log("✅ RESPONSE[$statusCode] => PATH: $uri\n DATA: $data");
    //Handle section expired
    if (response?.statusCode == 401) {
      GlobalEvent.instance.onTokenExpired.add(true);
    }
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    final statusCode = err?.response?.statusCode;
    final uri = err?.request?.path;
    var data = "";
    try {
      data = jsonEncode(err?.response?.data);
    } catch (e) {}
    logger.log("⚠️ ERROR[$statusCode] => PATH: $uri\n DATA: $data");
    return super.onError(err);
  }
}
