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
import 'package:google_sign_in/google_sign_in.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepository authRepo;
  final UserRepository userRepo;
  final AppCubit appCubit;

  SignInCubit({
    required this.authRepo,
    required this.userRepo,
    required this.appCubit,
  }) : super(const SignInState());

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
      final result = await authRepo.signIn(username, password);
      if (result != null) {
        UserEntity? myProfile = await userRepo.getProfile();
        appCubit.updateProfile(myProfile);
        authRepo.saveToken(result);
        emit(state.copyWith(signInStatus: LoadStatus.success));
        Get.offNamed(RouteConfig.main);
      } else {
        emit(state.copyWith(signInStatus: LoadStatus.failure));
      }
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(signInStatus: LoadStatus.failure));
    }
  }

  Future<void> signInGoogle() async {
    try {
      emit(state.copyWith(signInStatus: LoadStatus.loading));

      GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? googleAuth =
          await googleSignInAccount?.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user?.displayName != null) {
        emit(state.copyWith(signInStatus: LoadStatus.success));
        Get.offNamed(RouteConfig.main);
      }
    } catch (e) {
      AppSnackbar.showError(message: e.toString());
    }
  }
}
