import 'package:json_annotation/json_annotation.dart';

part 'remote_config_entity.g.dart';

@JsonSerializable()
class RemoteConfigEntity {
  @JsonKey()
  String databaseVersion;
}
