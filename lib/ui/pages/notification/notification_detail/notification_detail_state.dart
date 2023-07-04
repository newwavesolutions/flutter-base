part of 'notification_detail_cubit.dart';

class NotificationDetailState extends Equatable {
  final LoadStatus loadDataStatus;
  final LoadStatus markAsReadStatus;

  const NotificationDetailState({
    this.loadDataStatus = LoadStatus.initial,
    this.markAsReadStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
        markAsReadStatus,
      ];

  NotificationDetailState copyWith({
    LoadStatus? loadDataStatus,
    LoadStatus? markAsReadStatus,
  }) {
    return NotificationDetailState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
      markAsReadStatus: markAsReadStatus ?? this.markAsReadStatus,
    );
  }
}
