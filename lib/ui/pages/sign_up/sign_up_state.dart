part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  final LoadStatus signUpStatus;
  ValidatorError? nameValidatorError;
  ValidatorError? emailValidatorError;
  PasswordValidatorError? passwordValidatorError;
  String? apiErrorMessage;

  SignUpState({
    this.signUpStatus = LoadStatus.initial,
    this.nameValidatorError,
    this.emailValidatorError,
    this.passwordValidatorError,
    this.apiErrorMessage,
  });

  @override
  List<Object?> get props => [
        signUpStatus,
        nameValidatorError,
        emailValidatorError,
        passwordValidatorError,
        apiErrorMessage,
      ];

  SignUpState copyWith({
    LoadStatus? signUpStatus,
    ValidatorError? nameValidatorError,
    ValidatorError? emailValidatorError,
    PasswordValidatorError? passwordValidatorError,
    String? apiErrorMessage,
  }) {
    return SignUpState(
      signUpStatus: signUpStatus ?? this.signUpStatus,
      nameValidatorError: nameValidatorError ?? this.nameValidatorError,
      emailValidatorError: emailValidatorError ?? this.emailValidatorError,
      apiErrorMessage: apiErrorMessage ?? this.apiErrorMessage,
      passwordValidatorError:
          passwordValidatorError ?? this.passwordValidatorError,
    );
  }
}
