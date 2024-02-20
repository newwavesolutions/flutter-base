part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  final LoadStatus signInStatus;
  final String? email;
  final String? password;

  const SignInState({
    this.signInStatus = LoadStatus.initial,
    this.email,
    this.password,
  });

  @override
  List<Object?> get props => [
        signInStatus,
        email,
        password,
      ];

  SignInState copyWith({
    LoadStatus? signInStatus,
    String? email,
    String? password,
  }) {
    return SignInState(
      signInStatus: signInStatus ?? this.signInStatus,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
