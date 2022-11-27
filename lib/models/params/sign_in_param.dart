import 'package:json_annotation/json_annotation.dart';

part 'sign_in_param.g.dart';

@JsonSerializable()
class SignInParam {
  @JsonKey()
  final String? email;
  @JsonKey()
  final String? password;

  SignInParam({
    this.email,
    this.password,
  });

  factory SignInParam.fromJson(Map<String, dynamic> json) =>
      _$SignInParamFromJson(json);

  Map<String, dynamic> toJson() => _$SignInParamToJson(this);
}
