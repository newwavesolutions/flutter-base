part of 'user_info_cubit.dart';

class UserInfoState extends Equatable {
  final UserEntity? user;

  const UserInfoState({
    this.user,
  });

  UserInfoState copyWith({
    UserEntity? user,
  }) {
    return UserInfoState(
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        user,
      ];
}
