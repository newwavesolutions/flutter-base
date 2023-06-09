import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/router/route_config.dart';
import 'package:flutter_base/ui/commons/app_snackbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

part 'verification_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(const SignInState());

  void changeUsername({required String otp}) {
    emit(state.copyWith(otp: otp));
  }

  void signIn({required String verificationId}) async {
    final otp = state.otp ?? '';
    if (otp.isEmpty) {
      AppSnackbar.showError(message: 'otp is empty');
      return;
    }
    emit(state.copyWith(signInStatus: LoadStatus.loading));
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      // Sign the user in (or link) with the credential
      await FirebaseAuth.instance.signInWithCredential(credential);
      await Future.delayed(
        const Duration(seconds: 1),
      );
      emit(state.copyWith(signInStatus: LoadStatus.success));
      Get.toNamed(RouteConfig.main);
    } on FirebaseAuthException catch (error) {
      AppSnackbar.showError(message: error.toString());
      emit(state.copyWith(signInStatus: LoadStatus.failure));
    }
  }
}
