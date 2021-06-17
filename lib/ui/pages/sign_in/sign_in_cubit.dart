import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/entities/index.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/auth_repository.dart';
import 'package:flutter_base/utils/logger.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  AuthRepository repository;

  SignInCubit({this.repository}) : super(SignInState());

  void signIn(String username, String password) async {
    emit(state.copyWith(signInStatus: SignInStatus.LOADING));
    try {
      final result = await repository.signIn(username, password);
      await repository.saveToken(result);
      emit(state.copyWith(signInStatus: SignInStatus.SUCCESS));
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(signInStatus: SignInStatus.FAILURE));
    }
  }
}
