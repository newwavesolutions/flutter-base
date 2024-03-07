part of 'change_password_cubit.dart';

class ChangePasswordState extends Equatable {
  final LoadStatus changePasswordStatus;

  const ChangePasswordState({
    this.changePasswordStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        changePasswordStatus,
      ];

  ChangePasswordState copyWith({
    LoadStatus? changePasswordStatus,
  }) {
    return ChangePasswordState(
      changePasswordStatus: changePasswordStatus ?? this.changePasswordStatus,
    );
  }
}
