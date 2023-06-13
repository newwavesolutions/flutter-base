import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notification_list_state.dart';

class NotificationListCubit extends Cubit<NotificationListState> {
  NotificationListCubit() : super(const NotificationListState());

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      //Todo: add API calls
      emit(state.copyWith(loadDataStatus: LoadStatus.success));
    } catch (e) {
      //Todo: should print exception here
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }
}
