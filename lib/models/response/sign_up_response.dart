import 'package:json_annotation/json_annotation.dart';

part 'sign_up_response.g.dart';

@JsonSerializable()
class SignUpResponse {
  @JsonKey()
  final String? accessToken;
  @JsonKey()
  final String? refreshToken;
  @JsonKey()
  final String? userId;
  @JsonKey()
  final int? expiresIn;

  SignUpResponse({
    this.accessToken,
    this.refreshToken,
    this.userId,
    this.expiresIn,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpResponseToJson(this);
}
