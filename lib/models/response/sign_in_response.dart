import 'package:json_annotation/json_annotation.dart';

part 'sign_in_response.g.dart';

@JsonSerializable()
class SignInResponse {
  @JsonKey()
  final String? accessToken;
  @JsonKey()
  final String? refreshToken;
  @JsonKey()
  final String? userId;
  @JsonKey()
  final int? expiresIn;

  SignInResponse({
    this.accessToken,
    this.refreshToken,
    this.userId,
    this.expiresIn,
  });

  factory SignInResponse.fromJson(Map<String, dynamic> json) =>
      _$SignInResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignInResponseToJson(this);
}
