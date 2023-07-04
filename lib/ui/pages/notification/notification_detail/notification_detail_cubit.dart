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

  Future<void> markNotificationAsRead({required int id}) async {
    emit(state.copyWith(loadDataStatus: LoadStatus.loading));
    try {
      await notificationRepository.markAsRead(notificationId: id);
      emit(state.copyWith(loadDataStatus: LoadStatus.success));
    } catch (e) {
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }
}
