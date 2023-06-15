part of 'notification_list_cubit.dart';

class NotificationListState extends Equatable {
  final LoadStatus loadDataStatus;
  final List<NotificationEntity>? notifications;
  final int page;
  final int totalPages;

  const NotificationListState({
    this.loadDataStatus = LoadStatus.initial,
    this.notifications,
    this.page = 1,
    this.totalPages = 0,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        notifications,
        page,
        totalPages,
      ];

  NotificationListState copyWith({
    LoadStatus? loadDataStatus,
    List<NotificationEntity>? notifications,
    final int? page,
    final int? totalPages,
  }) {
    return NotificationListState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      notifications: notifications ?? this.notifications,
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
    );
  }
}
