import 'package:equatable/equatable.dart';
import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/models/entities/user/user_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/ui/pages/profile/update_profile/update_profile_navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final AppCubit appCubit;
  final UpdateProfileNavigator navigator;

  UpdateProfileCubit({
    required this.appCubit,
    required this.navigator,
  }) : super(const UpdateProfileState());

  Future<void> getUser() async {
    emit(
      state.copyWith(userStatus: LoadStatus.loading),
    );
    try {
      if (appCubit.state.user != null) {
        emit(state.copyWith(
          user: appCubit.state.user,
          userStatus: LoadStatus.success,
        ));
      }
    } catch (e) {
      emit(
        state.copyWith(userStatus: LoadStatus.failure),
      );
    }
  }

  Future<void> updateData({
    required String name,
    required String phone,
    required DateTime birthday,
    required String address,
  }) async {
    UserEntity user = UserEntity(
      id: appCubit.state.user?.id,
      username: name,
      phone: phone,
      birthday: birthday,
      address: address,
      avatarUrl: appCubit.state.user?.avatarUrl,
      email: appCubit.state.user?.email,
    );
    if (identical(user, appCubit.state.user)) {
      navigator.showErrorFlushbar(message: 'Username does not change');
      return;
    }
    emit(state.copyWith(
      userStatus: LoadStatus.loading,
    ));
    try {
      await appCubit.updateProfile(
        user,
      );
      emit(state.copyWith(
        userStatus: LoadStatus.success,
      ));
      navigator.pop(true);
    } catch (error) {
      emit(state.copyWith(
        userStatus: LoadStatus.failure,
      ));
    }
  }
}
