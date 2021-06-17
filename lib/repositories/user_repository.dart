import 'package:flutter_base/models/entities/index.dart';
import 'package:flutter_base/network/api_client.dart';

abstract class UserRepository {
  Future<UserEntity> getProfile();
}

class UserRepositoryImpl extends UserRepository {
  ApiClient _apiClient;

  UserRepositoryImpl(ApiClient client) {
    _apiClient = client;
  }

  @override
  Future<UserEntity> getProfile() async {
    await Future.delayed(Duration(seconds: 2));
    //Mock data
    return UserEntity.mockData();
  }
}
