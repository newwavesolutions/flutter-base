part of 'profile_tab_cubit.dart';

class ProfileTabState extends Equatable {
  final LoadStatus signOutStatus;

  ProfileTabState({
    this.signOutStatus = LoadStatus.INITIAL,
  });

  ProfileTabState copyWith({
    LoadStatus signOutStatus,
  }) {
    return ProfileTabState(
      signOutStatus: signOutStatus ?? this.signOutStatus,
    );
  }

  @override
  List<Object> get props => [
        signOutStatus,
      ];
}
