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
  @JsonKey()
  String? phone;
  @JsonKey()
  String? address;

  UserEntity(
      {this.id,
      this.username,
      this.birthday,
      this.avatarUrl,
      this.email,
      this.phone,
      this.address});

  factory UserEntity.mockData() {
    return UserEntity(
        id: 12345678,
        username: "newwave solution line8",
        birthday: DateTime.now(),
        avatarUrl:
            "https://tophinhanhdep.com/wp-content/uploads/2021/10/Cute-Doraemon-Wallpapers.png",
        email: "newwave.vn",
        phone: '+84 123456789',
        address: "111 tay spon ");
  }

  factory UserEntity.updateProfile({required UserEntity userEntity}) {
    return userEntity;
  }

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
