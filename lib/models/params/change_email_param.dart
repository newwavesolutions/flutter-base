import 'package:json_annotation/json_annotation.dart';

part 'change_email_param.g.dart';

@JsonSerializable()
class ChangeEmailParam {
  @JsonKey(name: 'new_username')
  String newUsername;

  ChangeEmailParam({
    this.newUsername,
  });

  factory ChangeEmailParam.fromBody(String newUsername) {
    return ChangeEmailParam(
      newUsername: newUsername,
    );
  }

  factory ChangeEmailParam.fromJson(Map<String, dynamic> json) => _$ChangeEmailParamFromJson(json);

  Map<String, dynamic> toJson() => _$ChangeEmailParamToJson(this);
}
