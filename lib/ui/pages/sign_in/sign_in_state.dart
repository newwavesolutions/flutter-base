part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  final LoadStatus signInStatus;
  final String? username;
  final String? password;
  ValidatorError? emailValidatorError;
  PasswordValidatorError? passwordValidatorError;

  SignInState({
    this.signInStatus = LoadStatus.initial,
    this.username,
    this.password,
    this.emailValidatorError,
    this.passwordValidatorError,
  });

  @override
  List<Object?> get props => [
        signInStatus,
        username,
        password,
        emailValidatorError,
        passwordValidatorError,
      ];

  SignInState copyWith({
    LoadStatus? signInStatus,
    String? username,
    String? password,
    ValidatorError? emailValidatorError,
    PasswordValidatorError? passwordValidatorError,
  }) {
    return SignInState(
      signInStatus: signInStatus ?? this.signInStatus,
      username: username ?? this.username,
      password: password ?? this.password,
      emailValidatorError: emailValidatorError ?? this.emailValidatorError,
      passwordValidatorError:
          passwordValidatorError ?? this.passwordValidatorError,
    );
  }
}
