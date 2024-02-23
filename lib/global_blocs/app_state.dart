part of 'app_cubit.dart';

class AppState extends Equatable {
  final UserEntity? user;
  final LoadStatus fetchProfileStatus;
  final LoadStatus updateProfileStatus;
  final LoadStatus getProfileStatus;

  const AppState({
    this.user,
    this.fetchProfileStatus = LoadStatus.initial,
    this.updateProfileStatus = LoadStatus.initial,
    this.getProfileStatus = LoadStatus.initial,
  });

  AppState copyWith({
    UserEntity? user,
    LoadStatus? fetchProfileStatus,
    LoadStatus? signOutStatus,
    LoadStatus? updateProfileStatus,
    LoadStatus? getProfileStatus,
  }) {
    return AppState(
      user: user ?? this.user,
      fetchProfileStatus: fetchProfileStatus ?? this.fetchProfileStatus,
      updateProfileStatus: updateProfileStatus ?? this.updateProfileStatus,
      getProfileStatus: getProfileStatus ?? this.getProfileStatus,
    );
  }

  AppState removeUser() {
    return AppState(
      user: user,
      fetchProfileStatus: fetchProfileStatus,
    );
  }

  @override
  List<Object?> get props => [
        user,
        fetchProfileStatus,
        updateProfileStatus,
        getProfileStatus,
      ];
}
