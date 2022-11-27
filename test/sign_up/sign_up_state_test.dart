import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/ui/pages/sign_up/sign_up_cubit.dart';
import 'package:flutter_base/utils/validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late SignUpState signUpState;

  setUpAll(() {
    signUpState = SignUpState();
  });

  test("Init state", () async {
    expect(signUpState, isA<Equatable>());

    expect(signUpState.signUpStatus, LoadStatus.initial);
    expect(signUpState.nameValidatorError, null);
    expect(signUpState.emailValidatorError, null);
    expect(signUpState.passwordValidatorError, null);
    expect(signUpState.apiErrorMessage, null);
  });

  test("Props property", () async {
    expect(signUpState.props.length, 6);
  });

  test("Copy with", () async {
    final newState = signUpState.copyWith(
      signUpStatus: LoadStatus.loading,
      nameValidatorError: ValidatorError.invalid,
      emailValidatorError: ValidatorError.invalid,
      passwordValidatorError: PasswordValidatorError.passwordInvalid,
      apiErrorMessage: "abc",
    );
    expect(identical(newState, signUpState), false);
    expect(newState.signUpStatus, LoadStatus.loading);
    expect(newState.nameValidatorError, ValidatorError.invalid);
    expect(newState.emailValidatorError, ValidatorError.invalid);
    expect(newState.apiErrorMessage, "abc");
    expect(newState.passwordValidatorError,
        PasswordValidatorError.passwordInvalid);
  });
}
