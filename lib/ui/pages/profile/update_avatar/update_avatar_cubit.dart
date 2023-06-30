import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/models/entities/user/user_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/ui/pages/profile/update_avatar/update_avatar_navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'update_avatar_state.dart';

class UpdateAvatarCubit extends Cubit<UpdateAvatarState> {
  final AppCubit appCubit;
  final UpdateAvatarNavigator navigator;

  UpdateAvatarCubit({
    required this.appCubit,
    required this.navigator,
  }) : super(const UpdateAvatarState());

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
}
