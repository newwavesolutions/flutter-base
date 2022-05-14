import 'package:flutter_base/database/secure_storage_helper.dart';
import 'package:flutter_base/network/api_client.dart';

import '../models/entities/token_entity.dart';

abstract class AuthRepository {
  Future<TokenEntity?> getToken();

  Future<void> saveToken(TokenEntity token);

  Future<void> removeToken();

  Future<TokenEntity?> signIn(String username, String password);
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
  Future<TokenEntity?> signIn(String username, String password) async {
    //Todo
    await Future.delayed(const Duration(seconds: 2));
    return TokenEntity(
        accessToken: 'app_access_token', refreshToken: 'app_refresh_token');
  }
}
