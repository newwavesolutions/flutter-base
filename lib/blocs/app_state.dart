part of 'app_cubit.dart';

class AppState extends Equatable {
  final UserEntity user;
  final LoadStatus fetchProfileStatus;
  final LoadStatus signOutStatus;

  AppState({
    this.user,
    this.fetchProfileStatus,
    this.signOutStatus,
  });

  AppState copyWith({
    UserEntity user,
    LoadStatus fetchProfileStatus,
    LoadStatus signOutStatus,
  }) {
    return new AppState(
      user: user ?? this.user,
      fetchProfileStatus: fetchProfileStatus ?? this.fetchProfileStatus,
      signOutStatus: signOutStatus ?? this.signOutStatus,
    );
  }

  AppState removeUser() {
    return AppState(
      user: user,
      fetchProfileStatus: this.fetchProfileStatus,
      signOutStatus: this.signOutStatus,
    );
  }

  @override
  List<Object> get props => [
        user,
        fetchProfileStatus,
        signOutStatus,
      ];
}
