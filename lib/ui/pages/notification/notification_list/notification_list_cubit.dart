import 'package:flutter_base/models/entities/notification/notification_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/notification_respository.dart';
import 'package:flutter_base/ui/pages/notification/notification_list/notification_list_navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'notification_list_state.dart';

class NotificationListCubit extends Cubit<NotificationListState> {
  NotificationListNavigator navigator;
  NotificationRepository notificationRepository;

  NotificationListCubit({
    required this.navigator,
    required this.notificationRepository,
  }) : super(const NotificationListState());

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.loading));
    try {
      final result = await notificationRepository.getNotifications(page: 1);
      emit(
        state.copyWith(
          notifications: result.results,
          loadDataStatus: LoadStatus.success,
          totalPages: result.totalPages,
          page: result.page,
        ),
      );
    } catch (e) {
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  Future<void> loadNextData() async {
    if (state.loadDataStatus != LoadStatus.success) {
      return;
    }
    emit(state.copyWith(loadDataStatus: LoadStatus.loadingMore));
    try {
      final result =
          await notificationRepository.getNotifications(page: state.page + 1);
      final newNotifications = state.notifications..addAll(result.results);
      emit(
        state.copyWith(
          loadDataStatus: LoadStatus.success,
          notifications: newNotifications,
          page: result.page,
          totalPages: result.totalPages,
        ),
      );
    } catch (e) {
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }

  Future<void> markNotificationAsRead({required int id}) async {
    emit(state.copyWith(markAsReadStatus: LoadStatus.loading));
    try {
      final _ = await notificationRepository.markAsRead(notificationId: id);
      final index =
          state.notifications.indexWhere((element) => element.id == id);
      state.notifications[index].isRead = true;
      emit(state.copyWith(
        markAsReadStatus: LoadStatus.success,
        notifications: state.notifications,
      ));
    } catch (e) {
      state.copyWith(markAsReadStatus: LoadStatus.failure);
    }
  }

  Future<void> markAllNotificationAsRead() async {
    emit(state.copyWith(markAllAsReadStatus: LoadStatus.loading));
    try {
      final _ = await notificationRepository.markAllAsRead();
      List<NotificationEntity> notifications =
          state.notifications.map((e) => e.copyWith(isRead: true)).toList();
      emit(
        state.copyWith(
          notifications: notifications,
          markAllAsReadStatus: LoadStatus.success,
        ),
      );
    } catch (e) {
      state.copyWith(markAllAsReadStatus: LoadStatus.failure);
    }
  }
}
