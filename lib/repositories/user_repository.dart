import 'package:flutter_base/models/params/sign_up_param.dart';
import 'package:flutter_base/models/response/sign_up_response.dart';
import 'package:flutter_base/network/api_client.dart';

import '../models/entities/user/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> getProfile();

  Future<SignUpResponse?> signUp(SignUpParam param);
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
  Future<SignUpResponse?> signUp(SignUpParam param) {
    return apiClient.signUp(param.toJson());
  }
}
