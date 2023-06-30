import 'package:flutter_base/models/entities/notification/notification_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/models/response/array_response.dart';
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
    emit(
      state.copyWith(loadDataStatus: LoadStatus.initial),
    );
    try {
      final result = await notificationRepository.getNotifications(page: 1);
      if (result.results.isNotEmpty) {
        emit(
          state.copyWith(
              notifications: result.results,
              loadDataStatus: LoadStatus.success),
        );
      }
    } catch (e) {
      emit(state.copyWith(
        loadDataStatus: LoadStatus.failure,
      ));
    }
  }

  Future<void> fetchNextNotifications() async {
    if (state.page == state.totalPages) {
      return;
    }
    if (state.loadDataStatus != LoadStatus.success) {
      return;
    }
    emit(state.copyWith(
      loadDataStatus: LoadStatus.loadingMore,
    ));
    try {
      final result = await notificationRepository.getNotifications(
        page: state.page + 1,
      );
      final resultList = state.notifications?..addAll(result.results);
      emit(state.copyWith(
          loadDataStatus: LoadStatus.success,
          notifications: resultList,
          page: state.page + 1,
          totalPages: result.totalPages));
    } catch (e) {
      emit(state.copyWith(
        loadDataStatus: LoadStatus.failure,
      ));
    }
  }

  Future<void> markNotificationAsRead({required int id}) async {
    emit(
      state.copyWith(loadDataStatus: LoadStatus.loading),
    );
    List<NotificationEntity> notifications = [...?state.notifications];
    final notificationJson = notifications
        .firstWhere((notification) => notification.id == id)
        .toJson();
    try {
      final result =
          await notificationRepository.markAsRead(body: notificationJson);
      emit(
        state.copyWith(
          notifications: result.results,
          loadDataStatus: LoadStatus.success,
        ),
      );
    } catch (e) {
      state.copyWith(loadDataStatus: LoadStatus.failure);
    }
  }

  Future<void> markAllNotificationAsRead() async {
    emit(
      state.copyWith(loadDataStatus: LoadStatus.loading),
    );
    List<NotificationEntity> notifications = [...?state.notifications];
    for (NotificationEntity item in notifications) {
      item.isRead = true;
    }
    try {
      final ArrayResponse<NotificationEntity> data =
          ArrayResponse<NotificationEntity>(
        page: state.page,
        totalPages: state.totalPages,
        results: notifications,
      );
      final result = await notificationRepository.markAllAsRead(
        body: data.toJson((value) => value.toJson()),
      );
      emit(
        state.copyWith(
          notifications: result.results,
          loadDataStatus: LoadStatus.success,
        ),
      );
    } catch (e) {
      state.copyWith(loadDataStatus: LoadStatus.failure);
    }
  }
}
