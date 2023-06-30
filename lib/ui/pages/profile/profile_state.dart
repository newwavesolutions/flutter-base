import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/models/entities/user/user_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';

class ProfileState extends Equatable {
  final LoadStatus signOutStatus;
  final LoadStatus userStatus;
  final UserEntity? user;
  final ThemeMode themeMode;

  const ProfileState({
    this.signOutStatus = LoadStatus.initial,
    this.user,
    this.userStatus = LoadStatus.initial,
    this.themeMode = ThemeMode.system,
  });

  ProfileState copyWith({
    LoadStatus? signOutStatus,
    UserEntity? user,
    LoadStatus? userStatus,
    ThemeMode? themeMode,
  }) {
    return ProfileState(
      signOutStatus: signOutStatus ?? this.signOutStatus,
      user: user ?? this.user,
      userStatus: userStatus ?? this.userStatus,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  List<Object?> get props => [
        signOutStatus,
        user,
        userStatus,
        themeMode,
      ];
}
