part of 'notification_detail_cubit.dart';

class NotificationDetailState extends Equatable {
  final LoadStatus loadDataStatus;

  const NotificationDetailState({
    this.loadDataStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        loadDataStatus,
      ];

  NotificationDetailState copyWith({
    LoadStatus? loadDataStatus,
  }) {
    return NotificationDetailState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
    );
  }
}
