import 'package:json_annotation/json_annotation.dart';

part 'notification_entity.g.dart';

@JsonSerializable()
class NotificationEntity {
  @JsonKey()
  int? id;
  @JsonKey()
  bool? isRead;
  @JsonKey()
  String? title;
  @JsonKey()
  String? message;
  @JsonKey()
  DateTime? createdAt;
  @JsonKey()
  String? imageUrl;

  NotificationEntity({
    this.id,
    this.isRead,
    this.title,
    this.message,
    this.createdAt,
    this.imageUrl,
  });

  factory NotificationEntity.fromJson(Map<String, dynamic> json) =>
      _$NotificationEntityFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationEntityToJson(this);
}
