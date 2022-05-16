import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/enums/load_status.dart';

class ProfileState extends Equatable {
  final LoadStatus signOutStatus;

  const ProfileState({
    this.signOutStatus = LoadStatus.initial,
  });

  ProfileState copyWith({
    LoadStatus? signOutStatus,
  }) {
    return ProfileState(
      signOutStatus: signOutStatus ?? this.signOutStatus,
    );
  }

  @override
  List<Object?> get props => [
        signOutStatus,
      ];
}
