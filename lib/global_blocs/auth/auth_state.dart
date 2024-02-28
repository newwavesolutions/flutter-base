part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final LoadStatus signOutStatus;

  const AuthState({
    this.signOutStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        signOutStatus,
      ];

  AuthState copyWith({
    LoadStatus? signOutStatus,
  }) {
    return AuthState(
      signOutStatus: signOutStatus ?? this.signOutStatus,
    );
  }
}
