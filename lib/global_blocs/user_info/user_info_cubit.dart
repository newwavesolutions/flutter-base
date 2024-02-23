import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/entities/user/user_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit() : super(const UserInfoState());

  void updateUser(UserEntity user) {
    emit(state.copyWith(user: user));
  }

  void removeUser(UserEntity user) {
    emit(const UserInfoState());
  }
}
