import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/models/entities/user/user_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/enums/load_status.dart';
import '../repositories/auth_repository.dart';
import '../repositories/user_repository.dart';
import '../utils/logger.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  UserRepository userRepo;
  AuthRepository authRepo;

  AppCubit({
    required this.userRepo,
    required this.authRepo,
  }) : super(const AppState());

  void fetchProfile() {
    emit(state.copyWith(fetchProfileStatus: LoadStatus.loading));
  }

  void updateProfile(UserEntity user) {
    emit(state.copyWith(user: user));
  }

  ///Sign Out
  void signOut() async {
    emit(state.copyWith(signOutStatus: LoadStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 2));
      await authRepo.removeToken();
      emit(state.removeUser().copyWith(
            signOutStatus: LoadStatus.success,
          ));
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(signOutStatus: LoadStatus.failure));
    }
  }

  /// check lifecycle app
  final _appLifeCycleState = StreamController<AppLifecycleState>.broadcast();
  Stream<AppLifecycleState> get appLifeCycleState => _appLifeCycleState.stream;
  void addAppLifecycleState(AppLifecycleState appLifecycleState) {
    _appLifeCycleState.add(appLifecycleState);
  }
  void _closeStream() {
    _appLifeCycleState.close();
  }

  /// check connectivity
  final _connectivity = Connectivity();
  Stream<ConnectivityResult> get connectivityChanged => _connectivity.onConnectivityChanged;
  Future<ConnectivityResult> get checkConnection => _connectivity.checkConnectivity();

  @override
  Future<void> close() {
    _closeStream();
    return super.close();
  }
}
