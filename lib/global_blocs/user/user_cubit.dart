import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/entities/user/user_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;

  UserCubit({
    required this.userRepository,
  }) : super(const UserState());

  Future<void> fetchUser() async {
    if (state.fetchUserStatus == LoadStatus.loading) {
      return;
    }
    emit(state.copyWith(fetchUserStatus: LoadStatus.loading));
    try {
      final user = await userRepository.getProfile();
      emit(state.copyWith(
        fetchUserStatus: LoadStatus.success,
        user: user,
      ));
    } catch (e) {
      emit(state.copyWith(fetchUserStatus: LoadStatus.failure));
    }
  }

  void updateUser(UserEntity user) {
    emit(state.copyWith(user: user));
  }

  void removeUser(UserEntity user) {
    emit(const UserState());
  }
}
