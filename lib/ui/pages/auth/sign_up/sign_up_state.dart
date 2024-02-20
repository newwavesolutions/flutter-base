part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  final LoadStatus signUpStatus;
  final String? fullName;
  final String? email;
  final String? password;
  final String? confirmPassword;

  const SignUpState({
    this.signUpStatus = LoadStatus.initial,
    this.fullName,
    this.email,
    this.password,
    this.confirmPassword,
  });

  @override
  List<Object?> get props => [
        signUpStatus,
        fullName,
        email,
        password,
        confirmPassword,
      ];

  SignUpState copyWith({
    LoadStatus? signUpStatus,
    String? fullName,
    String? email,
    String? password,
    String? confirmPassword,
  }) {
    return SignUpState(
      signUpStatus: signUpStatus ?? this.signUpStatus,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }
}
