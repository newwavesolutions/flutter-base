import 'package:equatable/equatable.dart';
import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/models/entities/token_entity.dart';
import 'package:flutter_base/models/entities/user/user_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/models/params/sign_in_param.dart';
import 'package:flutter_base/repositories/auth_repository.dart';
import 'package:flutter_base/utils/validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/user_repository.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepository authRepo;
  final UserRepository userRepo;
  final AppCubit appCubit;

  SignInCubit({
    required this.authRepo,
    required this.userRepo,
    required this.appCubit,
  }) : super(SignInState());

  void changeUsername({required String username}) {
    emit(state.copyWith(username: username));
  }

  void changePassword({required String password}) {
    emit(state.copyWith(password: password));
  }

  Future<void> checkValidateAndSignIn({
    required String email,
    required String password,
  }) async {
    final emailValidate = EmailValidator(email).perform(isCheckRequire: true);
    final passwordValidate =
        PasswordValidator(password).perform(isCheckRequire: true);

    final newState = state.copyWith();
    newState.emailValidatorError = emailValidate;
    newState.passwordValidatorError = passwordValidate;
    emit(newState);
  }

  Future<void> signIn(SignInParam param) async {
    emit(state.copyWith(signInStatus: LoadStatus.loading));

    try {
      final result = await authRepo.signIn(param);

      if (result != null) {
        UserEntity? myProfile = await userRepo.getProfile();
        appCubit.updateProfile(myProfile);

        final tokenEntity = TokenEntity(
          accessToken: result.accessToken ?? "",
          refreshToken: result.refreshToken ?? "",
        );
        authRepo.saveToken(tokenEntity);
        emit(state.copyWith(signInStatus: LoadStatus.success));
      } else {
        emit(state.copyWith(signInStatus: LoadStatus.failure));
      }
    } catch (error) {
      emit(state.copyWith(signInStatus: LoadStatus.failure));
    }
  }
}
