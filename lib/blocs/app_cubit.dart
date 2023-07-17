import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/entities/user/user_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/enums/load_status.dart';
import '../repositories/auth_repository.dart';
import '../repositories/user_repository.dart';
import '../utils/logger.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  UserRepository userRepo;
  AuthRepository authRepo;

  AppCubit({
    required this.userRepo,
    required this.authRepo,
  }) : super(const AppState());

  Future<void> getProfile() async {
    try {
      final result = await userRepo.getProfile();
      emit(
        state.copyWith(
          user: result,
          getProfileStatus: LoadStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(getProfileStatus: LoadStatus.failure),
      );
    }
  }

  void fetchProfile() {
    emit(state.copyWith(fetchProfileStatus: LoadStatus.loading));
  }

  Future<void> updateProfile(UserEntity user) async {
    emit(state.copyWith(updateProfileStatus: LoadStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 2));
      final result = await userRepo.updateProfile(userEntity: user);
      emit(state.copyWith(
        user: result,
        updateProfileStatus: LoadStatus.success,
      ));
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(signOutStatus: LoadStatus.failure));
    }
  }

  ///Sign Out
  Future<void> signOut() async {
    emit(state.copyWith(signOutStatus: LoadStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 2));
      await authRepo.removeToken();
      emit(state.removeUser().copyWith(signOutStatus: LoadStatus.success));
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(signOutStatus: LoadStatus.failure));
    }
  }
}
