part of 'notification_list_cubit.dart';

class NotificationListState extends Equatable {
  final LoadStatus loadDataStatus;
  final LoadStatus markAsReadStatus;
  final LoadStatus markAllAsReadStatus;
  final List<NotificationEntity> notifications;
  final int page;
  final int totalPages;

  const NotificationListState({
    this.loadDataStatus = LoadStatus.initial,
    this.markAsReadStatus = LoadStatus.initial,
    this.markAllAsReadStatus = LoadStatus.initial,
    this.notifications = const [],
    this.page = 1,
    this.totalPages = 0,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        markAsReadStatus,
        markAllAsReadStatus,
        notifications,
        page,
        totalPages,
      ];

  NotificationListState copyWith({
    LoadStatus? loadDataStatus,
    LoadStatus? markAsReadStatus,
    LoadStatus? markAllAsReadStatus,
    List<NotificationEntity>? notifications,
    int? page,
    int? totalPages,
  }) {
    return NotificationListState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      markAsReadStatus: markAsReadStatus ?? this.markAsReadStatus,
      markAllAsReadStatus: markAllAsReadStatus ?? this.markAllAsReadStatus,
      notifications: notifications ?? this.notifications,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
    );
  }
}
