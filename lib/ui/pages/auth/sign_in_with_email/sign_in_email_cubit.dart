import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/models/entities/user/user_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/auth_repository.dart';
import 'package:flutter_base/repositories/user_repository.dart';
import 'package:flutter_base/router/route_config.dart';
import 'package:flutter_base/ui/commons/app_snackbar.dart';
import 'package:flutter_base/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

part 'sign_in_email_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(const SignInState());

  void changeUsername({required String username}) {
    emit(state.copyWith(username: username));
  }

  void changePassword({required String password}) {
    emit(state.copyWith(password: password));
  }

  void signIn() async {
    final username = state.username ?? '';
    final password = state.password ?? '';
    if (username.isEmpty) {
      AppSnackbar.showError(message: 'Username is empty');
      return;
    }
    if (password.isEmpty) {
      AppSnackbar.showError(message: 'Password is empty');
      return;
    }
    emit(state.copyWith(signInStatus: LoadStatus.loading));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: username,
        password: password,
      );
      emit(state.copyWith(signInStatus: LoadStatus.success));
      Get.offNamed(RouteConfig.main);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        AppSnackbar.showError(message: 'Username not found');
      } else if (e.code == 'wrong-password') {
        AppSnackbar.showError(message: 'incorrect password');
      }
      emit(state.copyWith(signInStatus: LoadStatus.failure));
    }
  }
}
