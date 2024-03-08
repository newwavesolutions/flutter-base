import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_base/global_blocs/user/user_cubit.dart';
import 'package:flutter_base/models/entities/user/user_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/user_repository.dart';
import 'package:flutter_base/ui/pages/profile/update_avatar/update_avatar_navigator.dart';
import 'package:flutter_base/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'update_avatar_state.dart';

class UpdateAvatarCubit extends Cubit<UpdateAvatarState> {
  final UpdateAvatarNavigator navigator;
  final UserRepository userRepository;
  final UserCubit userCubit;

  UpdateAvatarCubit({
    required this.navigator,
    required this.userRepository,
    required this.userCubit,
  }) : super(const UpdateAvatarState());

  Future<void> updateImage(File file) async {
    emit(state.copyWith(updateImageStatus: LoadStatus.loading));
    try {
      final result = await userRepository.uploadAvatar(file);
      if (result != null) {
        userCubit.updateUser(result);
        emit(state.copyWith(
          updateImageStatus: LoadStatus.success,
          image: file,
        ));
        navigator.showSuccessFlushbar(message: 'Update Avatar Successfully!');
      } else {
        emit(state.copyWith(updateImageStatus: LoadStatus.failure));
        navigator.showErrorFlushbar(message: 'Update Avatar Failed!');
      }
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(updateImageStatus: LoadStatus.failure));
    }
  }
}
