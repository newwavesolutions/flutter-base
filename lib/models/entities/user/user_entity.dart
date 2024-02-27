import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  @JsonKey()
  int? id;
  @JsonKey()
  String? username;
  @JsonKey()
  DateTime? birthday;
  @JsonKey()
  String? avatarUrl;
  @JsonKey()
  String? email;

  UserEntity({
    this.id,
    this.username,
    this.birthday,
    this.avatarUrl,
    this.email,
  });

  factory UserEntity.mockData() {
    return UserEntity(
      id: 12345678,
      username: "NWS",
      birthday: DateTime.now(),
      avatarUrl: "https://picsum.photos/400",
      email: "mobile@newwave.vn",
    );
  }

  factory UserEntity.updateProfile({required UserEntity userEntity}) {
    return userEntity;
  }

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
