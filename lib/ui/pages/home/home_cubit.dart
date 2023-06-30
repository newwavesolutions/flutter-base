import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final AppCubit appCubit;

  HomeCubit({
    required this.appCubit,
  }) : super(const HomeState());

  Future<void> getAvatar() async {
    try {
      if (appCubit.state.user != null) {
        emit(state.copyWith(
          urlAvatar: appCubit.state.user?.avatarUrl,
          loadDataStatus: LoadStatus.failure,
        ));
      }
    } catch (e) {
      emit(
        state.copyWith(loadDataStatus: LoadStatus.failure),
      );
    }
  }
}
