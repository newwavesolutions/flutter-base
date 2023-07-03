import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_base/database/secure_storage_helper.dart';
import 'package:flutter_base/network/api_util.dart';
import 'package:flutter_base/router/route_config.dart';
import 'package:flutter_base/utils/logger.dart';
import 'package:go_router/go_router.dart';

class ApiInterceptors extends QueuedInterceptorsWrapper {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final method = options.method;
    final uri = options.uri;
    final data = options.data;
    final token = await SecureStorageHelper.instance.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer ${token.accessToken}';
    }
    if (method == 'GET') {
      logger.log(
          "✈️ REQUEST[$method] => PATH: $uri \n Token: ${options.headers}",
          printFullText: true);
    } else {
      try {
        logger.log(
            "✈️ REQUEST[$method] => PATH: $uri \n Token: ${token?.accessToken} \n DATA: ${jsonEncode(data)}",
            printFullText: true);
      } catch (e) {
        logger.log(
            "✈️ REQUEST[$method] => PATH: $uri \n Token: ${token?.accessToken} \n DATA: $data",
            printFullText: true);
      }
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final statusCode = response.statusCode;
    final uri = response.requestOptions.uri;
    final data = jsonEncode(response.data);
    logger.log("✅ RESPONSE[$statusCode] => PATH: $uri\n DATA: $data");
    //Handle section expired
    // if (response.statusCode == 401) {
    //   SecureStorageHelper.instance.removeToken();
    //   _forceSignIn();
    // }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;
    final path = err.requestOptions.path;
    final uri = err.requestOptions.uri;
    final RequestOptions request = err.requestOptions;
    if (kDebugMode) {
      logger.e(
          "⚠️ ERROR[$statusCode] => PATH: $path \n Response: ${err.response?.data}");
    }
    switch (statusCode) {
      case 401:
        final saveToken = await SecureStorageHelper.instance.getToken();
        List<String> tokens =
            err.requestOptions.headers['Authorization'].toString().split(' ');

        String tokenRequest = tokens.length > 1 ? tokens[1] : "";
        if (saveToken != null && saveToken.accessToken != tokenRequest) {
          final cloneReq = await cloneRequest(
            accessToken: saveToken.accessToken,
            request: request,
            uri: uri,
          );
          return handler.resolve(cloneReq);
        }

        if (saveToken == null) {
          return handler.next(err);
        }

        try {
          final result = await ApiUtil.onRefreshToken(
            saveToken.refreshToken,
          );

          if (result != null) {
            SecureStorageHelper.instance.saveToken(result);

            final cloneReq = await cloneRequest(
              accessToken: result.accessToken,
              request: request,
              uri: uri,
            );
            return handler.resolve(cloneReq);
          } else {
            if (kDebugMode) {
              logger.e("Response refresh token is null");
            }
            _forceSignIn();
            // return handler.next(err);
          }
        } catch (e) {
          if (kDebugMode) {
            logger.e(
                "Api refresh token error $e, msg: ${(e as DioError).response}");
          }
          _forceSignIn();
          // return handler.next(err);
        }
      default:
        handler.next(err);
    }
  }

  Future<Response> cloneRequest({
    required String accessToken,
    required RequestOptions request,
    required Uri uri,
  }) async {
    final newOptions = Options(
      method: request.method,
      headers: request.headers,
    );
    newOptions.headers!['Authorization'] = 'Bearer $accessToken';
    return await ApiUtil.getDio().requestUri(
      uri,
      options: newOptions,
      data: request.data,
    );
  }

  void _forceSignIn() {
    while (GoRouter.of(AppRouter.navigationKey.currentContext!).canPop()) {
      GoRouter.of(AppRouter.navigationKey.currentContext!).pop();
    }
    GoRouter.of(AppRouter.navigationKey.currentContext!)
        .pushReplacementNamed(AppRouter.signIn);
  }
}
