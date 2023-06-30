import 'package:flutter_base/network/api_client.dart';

import '../models/entities/user/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> getProfile();
  Future<UserEntity> updateProfile({required UserEntity userEntity});
}

class UserRepositoryImpl extends UserRepository {
  ApiClient apiClient;

  UserRepositoryImpl({required this.apiClient});

  @override
  Future<UserEntity> getProfile() async {
    await Future.delayed(const Duration(seconds: 2));
    //Mock data
    return UserEntity.mockData();
  }

  @override
  Future<UserEntity> updateProfile({required UserEntity userEntity}) async {
    return UserEntity.updateProfile(userEntity: userEntity);
  }
}
