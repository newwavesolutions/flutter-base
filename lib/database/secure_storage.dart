import 'dart:convert';

import 'package:flutter_base/database/share_preferences_helper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/entities/token_entity.dart';

class SecureStorage {
  static const _apiTokenKey = '_apiTokenKey';

  final FlutterSecureStorage _storage;

  SecureStorage._internal(this._storage);

  static final SecureStorage _singleton = SecureStorage._internal(FlutterSecureStorage());

  factory SecureStorage() {
    return _singleton;
  }

  factory SecureStorage.getInstance() {
    return _singleton;
  }

  //Save token
  void saveToken(TokenEntity token) async {
    if (token == null) {
      await _storage.delete(key: _apiTokenKey);
      SharedPreferencesHelper.setApiTokenKey(null);
    } else {
      await _storage.write(key: _apiTokenKey, value: jsonEncode(token.toJson()));
      SharedPreferencesHelper.setApiTokenKey(_apiTokenKey);
    }
  }

  //Get token
  Future<TokenEntity> getToken() async {
    try {
      final key = await SharedPreferencesHelper.getApiTokenKey();
      final tokenEncoded = await _storage.read(key: key);
      return TokenEntity.fromJson(jsonDecode(tokenEncoded) as Map<String, dynamic>);
    } catch (e) {
      return null;
    }
  }
}
