import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/ui/pages/sign_in/sign_in_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late SignInState signInState;

  setUpAll(() {
    signInState = SignInState();
  });

  test("Init state", () async {
    expect(signInState, isA<Equatable>());

    expect(signInState.signInStatus, LoadStatus.initial);
    expect(signInState.username, null);
    expect(signInState.password, null);
    expect(signInState.emailValidatorError, null);
    expect(signInState.passwordValidatorError, null);
  });

  test("Props property", () async {
    expect(signInState.props.length, 5);
  });

  test("Copy with", () async {
    final newState = signInState.copyWith();
    expect(identical(newState, signInState), false);
  });
}
