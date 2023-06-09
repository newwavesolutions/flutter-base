import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/router/route_config.dart';
import 'package:flutter_base/ui/commons/app_snackbar.dart';
import 'package:flutter_base/ui/pages/auth/verification_phone_number/verification_page.dart';
import 'package:flutter_base/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

part 'sign_in_phone_number_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(const SignInState());

  void changeUsername({required String phoneNumber}) {
    emit(state.copyWith(phoneNumber: phoneNumber));
  }

  Future<void> signIn() async {
    final phoneNumber = '+84${state.phoneNumber}';
    if (phoneNumber.isEmpty) {
      AppSnackbar.showError(message: 'Username is empty');
      return;
    }
    try {
      emit(state.copyWith(signInStatus: LoadStatus.loading));
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          debugPrint("verificationCompleted");
        },
        verificationFailed: (FirebaseAuthException e) {
          AppSnackbar.showError(message: e.toString());
          debugPrint(e.toString());
        },
        codeSent: (String verificationId, int? resendToken) {
          emit(state.copyWith(signInStatus: LoadStatus.success));
          Get.toNamed(
            RouteConfig.opt,
            arguments: VerificationPageArguments(
              verificationId: verificationId,
              phone: phoneNumber,
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      logger.e(e);
      emit(state.copyWith(signInStatus: LoadStatus.failure));
    }
  }
}
