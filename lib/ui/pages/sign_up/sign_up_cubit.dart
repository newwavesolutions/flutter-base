import 'package:equatable/equatable.dart';
import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/models/entities/token_entity.dart';
import 'package:flutter_base/models/entities/user/user_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/models/params/sign_up_param.dart';
import 'package:flutter_base/repositories/auth_repository.dart';
import 'package:flutter_base/repositories/user_repository.dart';
import 'package:flutter_base/utils/validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepo;
  final UserRepository userRepo;
  final AppCubit appCubit;

  SignUpCubit({
    required this.authRepo,
    required this.userRepo,
    required this.appCubit,
  }) : super(SignUpState());

  Future<void> checkValidate({
    required String name,
    required String email,
    required String password,
  }) async {
    final emailValidate = EmailValidator(email).perform(isCheckRequire: true);
    final passwordValidate =
        PasswordValidator(password).perform(isCheckRequire: true);
    final nameValidate = NameValidator(name).perform(isCheckRequire: true);

    final newState = state.copyWith();
    newState.emailValidatorError = emailValidate;
    newState.passwordValidatorError = passwordValidate;
    newState.nameValidatorError = nameValidate;
    emit(newState);
  }

  Future<void> signUp(SignUpParam param) async {
    emit(state.copyWith(signUpStatus: LoadStatus.loading));

    try {
      final result = await userRepo.signUp(param);

      if (result != null) {
        UserEntity? myProfile = await userRepo.getProfile();
        appCubit.updateProfile(myProfile);

        final tokenEntity = TokenEntity(
          accessToken: result.accessToken ?? "",
          refreshToken: result.refreshToken ?? "",
        );
        authRepo.saveToken(tokenEntity);
        emit(state.copyWith(signUpStatus: LoadStatus.success));
      } else {
        emit(state.copyWith(signUpStatus: LoadStatus.failure));
      }
    } catch (error) {
      emit(
        state.copyWith(
          signUpStatus: LoadStatus.failure,
          apiErrorMessage: "Error",
        ),
      );
    }
  }
}
