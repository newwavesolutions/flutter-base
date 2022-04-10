part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  final LoadStatus signInStatus;
  final String? username;
  final String? password;

  const SignInState({
    this.signInStatus = LoadStatus.initial,
    this.username,
    this.password,
  });

  @override
  List<Object?> get props => [
        signInStatus,
        username,
        password,
      ];

  SignInState copyWith({
    LoadStatus? signInStatus,
    String? username,
    String? password,
  }) {
    return SignInState(
      signInStatus: signInStatus ?? this.signInStatus,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }
}
