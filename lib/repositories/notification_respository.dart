import 'package:flutter_base/models/entities/notification/notification_entity.dart';
import 'package:flutter_base/models/response/array_response.dart';
import 'package:flutter_base/network/api_client.dart';

abstract class NotificationRepository {
  Future<ArrayResponse<NotificationEntity>> getNotifications(
      {required int page});

  Future<ArrayResponse<NotificationEntity>> markAllAsRead(
      {required Map<String, dynamic> body});

  Future<ArrayResponse<NotificationEntity>> markAsRead(
      {required Map<String, dynamic> body});
}

class NotificationRepositoryImpl extends NotificationRepository {
  ApiClient apiClient;

  NotificationRepositoryImpl({required this.apiClient});

  @override
  Future<ArrayResponse<NotificationEntity>> getNotifications(
      {required int page}) async {
    return await apiClient.getNotifications(page);
  }

  @override
  Future<ArrayResponse<NotificationEntity>> markAllAsRead(
      {required Map<String, dynamic> body}) async {
    return await apiClient.markAllAsRead(body);
  }

  @override
  Future<ArrayResponse<NotificationEntity>> markAsRead(
      {required Map<String, dynamic> body}) async {
    return await apiClient.markAsRead(body);
  }
}
