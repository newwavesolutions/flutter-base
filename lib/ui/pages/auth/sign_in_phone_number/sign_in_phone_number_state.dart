part of 'sign_in_phone_number_cubit.dart';

class SignInState extends Equatable {
  final LoadStatus signInStatus;
  final String? phoneNumber;

  const SignInState({
    this.signInStatus = LoadStatus.initial,
    this.phoneNumber,
  });

  @override
  List<Object?> get props => [
        signInStatus,
        phoneNumber,
      ];

  SignInState copyWith({
    LoadStatus? signInStatus,
    String? phoneNumber,
  }) {
    return SignInState(
      signInStatus: signInStatus ?? this.signInStatus,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
