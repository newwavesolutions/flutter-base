import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/auth_repository.dart';

part 'profile_tab_state.dart';

class ProfileTabCubit extends Cubit<ProfileTabState> {
  AuthRepository repository;

  ProfileTabCubit({this.repository}) : super(ProfileTabState());

  void signOut() async {
    emit(state.copyWith(signOutStatus: LoadStatus.LOADING));
    await repository.removeToken();
    await Future.delayed(Duration(seconds: 2));
    emit(state.copyWith(signOutStatus: LoadStatus.SUCCESS));
  }
}
