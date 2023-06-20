import 'package:flutter_base/models/entities/notification/notification_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/notification_respository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'notification_detail_state.dart';

class NotificationDetailCubit extends Cubit<NotificationDetailState> {
  final NotificationRepository notificationRepository;

  NotificationDetailCubit({
    required this.notificationRepository,
  }) : super(const NotificationDetailState());

  Future<void> markNotificationAsRead(
      {required NotificationEntity notification}) async {
    emit(
      state.copyWith(loadDataStatus: LoadStatus.loading),
    );
    final notificationJson = notification.toJson();
    try {
      await notificationRepository.markAsRead(body: notificationJson);
      emit(
        state.copyWith(
          loadDataStatus: LoadStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadDataStatus: LoadStatus.failure,
        ),
      );
    }
  }
}
