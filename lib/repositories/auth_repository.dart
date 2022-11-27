import 'package:flutter_base/database/secure_storage_helper.dart';
import 'package:flutter_base/models/params/sign_in_param.dart';
import 'package:flutter_base/models/response/sign_in_response.dart';
import 'package:flutter_base/network/api_client.dart';

import '../models/entities/token_entity.dart';

abstract class AuthRepository {
  Future<TokenEntity?> getToken();

  Future<void> saveToken(TokenEntity token);

  Future<void> removeToken();

  Future<SignInResponse?> signIn(SignInParam param);
}

class AuthRepositoryImpl extends AuthRepository {
  ApiClient apiClient;

  AuthRepositoryImpl({required this.apiClient});

  @override
  Future<TokenEntity?> getToken() async {
    return await SecureStorageHelper.instance.getToken();
  }

  @override
  Future<void> removeToken() async {
    return SecureStorageHelper.instance.removeToken();
  }

  @override
  Future<void> saveToken(TokenEntity token) async {
    return SecureStorageHelper.instance.saveToken(token);
  }

  @override
  Future<SignInResponse?> signIn(SignInParam param) async {
    return apiClient.authLogin(param.toJson());
  }
}
