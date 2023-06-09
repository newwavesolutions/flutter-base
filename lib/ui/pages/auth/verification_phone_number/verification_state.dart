part of 'verification_cubit.dart';

class SignInState extends Equatable {
  final LoadStatus signInStatus;
  final String? otp;

  const SignInState({
    this.signInStatus = LoadStatus.initial,
    this.otp,
  });

  @override
  List<Object?> get props => [
        signInStatus,
        otp,
      ];

  SignInState copyWith({
    LoadStatus? signInStatus,
    String? otp,
  }) {
    return SignInState(
      signInStatus: signInStatus ?? this.signInStatus,
      otp: otp ?? this.otp,
    );
  }
}
