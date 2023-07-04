import 'package:json_annotation/json_annotation.dart';

part 'notification_entity.g.dart';

@JsonSerializable()
class NotificationEntity {
  @JsonKey()
  int id;
  @JsonKey()
  bool isRead;
  @JsonKey()
  String? title;
  @JsonKey()
  String? message;
  @JsonKey()
  DateTime? createdAt;
  @JsonKey()
  String? imageUrl;

  NotificationEntity({
    this.id = 0,
    this.isRead = false,
    this.title,
    this.message,
    this.createdAt,
    this.imageUrl,
  });

  factory NotificationEntity.fromJson(Map<String, dynamic> json) =>
      _$NotificationEntityFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationEntityToJson(this);

  NotificationEntity copyWith({
    int? id,
    bool? isRead,
    String? title,
    String? message,
    DateTime? createdAt,
    String? imageUrl,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      isRead: isRead ?? this.isRead,
      title: title ?? this.title,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
