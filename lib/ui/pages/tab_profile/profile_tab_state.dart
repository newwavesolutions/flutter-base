import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/enums/load_status.dart';

class ProfileTabState extends Equatable {
  final LoadStatus signOutStatus;

  const ProfileTabState({
    this.signOutStatus = LoadStatus.initial,
  });

  ProfileTabState copyWith({
    LoadStatus? signOutStatus,
  }) {
    return ProfileTabState(
      signOutStatus: signOutStatus ?? this.signOutStatus,
    );
  }

  @override
  List<Object?> get props => [
        signOutStatus,
      ];
}
