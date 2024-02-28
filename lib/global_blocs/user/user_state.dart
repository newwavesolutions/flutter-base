part of 'user_cubit.dart';

class UserState extends Equatable {
  final UserEntity? user;
  final LoadStatus fetchUserStatus;

  const UserState({
    this.user,
    this.fetchUserStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
        user,
        fetchUserStatus,
      ];

  UserState copyWith({
    UserEntity? user,
    LoadStatus? fetchUserStatus,
  }) {
    return UserState(
      user: user ?? this.user,
      fetchUserStatus: fetchUserStatus ?? this.fetchUserStatus,
    );
  }
}
