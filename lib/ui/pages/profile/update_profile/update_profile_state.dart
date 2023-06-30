part of 'update_profile_cubit.dart';

class UpdateProfileState extends Equatable {
  final LoadStatus userStatus;
  final UserEntity? user;
  final DateTime? birthday;
  final LoadStatus birthdayStatus;

  const UpdateProfileState({
    this.userStatus = LoadStatus.initial,
    this.user,
    this.birthday,
    this.birthdayStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        userStatus,
        user,
        birthday,
        birthdayStatus,
      ];

  UpdateProfileState copyWith({
    LoadStatus? userStatus,
    UserEntity? user,
    DateTime? birthday,
    LoadStatus? birthdayStatus,
  }) {
    return UpdateProfileState(
      userStatus: userStatus ?? this.userStatus,
      user: user ?? this.user,
      birthday: birthday ?? this.birthday,
      birthdayStatus: birthdayStatus ?? this.birthdayStatus,
    );
  }
}
