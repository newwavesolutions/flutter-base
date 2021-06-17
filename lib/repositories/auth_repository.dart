import 'package:flutter_base/models/entities/index.dart';
import 'package:flutter_base/network/api_client.dart';

import '../database/secure_storage.dart';

abstract class AuthRepository {
  Future<TokenEntity> getToken();

  Future<void> saveToken(TokenEntity token);

  Future<void> removeToken();

  Future<TokenEntity> signIn(String username, String password);
}

class AuthRepositoryImpl extends AuthRepository {
  ApiClient _apiClient;

  AuthRepositoryImpl(ApiClient client) {
    _apiClient = client;
  }

  @override
  Future<TokenEntity> getToken() async {
    return SecureStorage.getInstance().getToken();
  }

  @override
  Future<void> removeToken() async {
    return SecureStorage.getInstance().saveToken(null);
  }

  @override
  Future<void> saveToken(TokenEntity token) async {
    return SecureStorage.getInstance().saveToken(token);
  }

  @override
  Future<TokenEntity> signIn(String username, String password) async {
    //Todo
    await Future.delayed(Duration(seconds: 2));
    return TokenEntity(accessToken: 'app_access_token', refreshToken: 'app_refresh_token');
  }
}
