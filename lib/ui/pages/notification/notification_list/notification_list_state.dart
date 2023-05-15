part of 'notification_list_cubit.dart';

class NotificationListState extends Equatable {
  final LoadStatus loadDataStatus;

  const NotificationListState({
    this.loadDataStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
      ];

  NotificationListState copyWith({
    LoadStatus? loadDataStatus,
  }) {
    return NotificationListState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
    );
  }
}
