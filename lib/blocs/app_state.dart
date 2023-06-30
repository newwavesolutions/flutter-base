part of 'app_cubit.dart';

class AppState extends Equatable {
  final UserEntity? user;
  final LoadStatus fetchProfileStatus;
  final LoadStatus signOutStatus;
  final LoadStatus getProfileStatus;
  final LoadStatus updateProfileStatus;

  const AppState({
    this.user,
    this.fetchProfileStatus = LoadStatus.initial,
    this.signOutStatus = LoadStatus.initial,
    this.getProfileStatus = LoadStatus.initial,
    this.updateProfileStatus = LoadStatus.initial,
  });

  AppState copyWith({
    UserEntity? user,
    LoadStatus? fetchProfileStatus,
    LoadStatus? signOutStatus,
    LoadStatus? getProfileStatus,
    LoadStatus? updateProfileStatus,
  }) {
    return AppState(
      user: user ?? this.user,
      fetchProfileStatus: fetchProfileStatus ?? this.fetchProfileStatus,
      signOutStatus: signOutStatus ?? this.signOutStatus,
      getProfileStatus: getProfileStatus ?? this.getProfileStatus,
      updateProfileStatus: updateProfileStatus ?? this.updateProfileStatus,
    );
  }

  AppState removeUser() {
    return AppState(
      user: user,
      fetchProfileStatus: fetchProfileStatus,
      signOutStatus: signOutStatus,
      updateProfileStatus: updateProfileStatus,
    );
  }

  @override
  List<Object?> get props => [
        user,
        fetchProfileStatus,
        signOutStatus,
        getProfileStatus,
        updateProfileStatus,
      ];
}
