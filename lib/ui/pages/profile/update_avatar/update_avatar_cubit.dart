import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/models/entities/user/user_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

part 'update_avatar_state.dart';

class UpdateAvatarCubit extends Cubit<UpdateAvatarState> {
  final AppCubit appCubit;

  UpdateAvatarCubit({required this.appCubit})
      : super(const UpdateAvatarState());

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

  Future<void> getImageFromCollection() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      emit(
        state.copyWith(imageCollectionStatus: LoadStatus.failure),
      );
      return;
    } else {
      Get.back();
      emit(
        state.copyWith(
          image: File(image.path),
          imageCollectionStatus: LoadStatus.success,
        ),
      );
    }
  }

  Future<void> getImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) {
      emit(
        state.copyWith(imageCameraStatus: LoadStatus.failure),
      );
      return;
    } else {
      Get.back();
      emit(
        state.copyWith(
          image: File(image.path),
          imageCameraStatus: LoadStatus.success,
        ),
      );
    }
  }
}
