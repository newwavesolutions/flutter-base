import 'package:flutter_base/models/entities/entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token_entity.g.dart';

@JsonSerializable()
class TokenEntity {
  @JsonKey()
  String accessToken;
  @JsonKey(name: 'refresh_token')
  String refreshToken;

  TokenEntity({this.accessToken, this.refreshToken});

  factory TokenEntity.fromJson(Map<String, dynamic> json) => _$TokenEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TokenEntityToJson(this);
}
