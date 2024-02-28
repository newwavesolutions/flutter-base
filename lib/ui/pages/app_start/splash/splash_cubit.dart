import 'package:flutter_base/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'splash_navigator.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final SplashNavigator navigator;
  final AuthRepository authRepo;

  SplashCubit({
    required this.navigator,
    required this.authRepo,
  }) : super(const SplashState());

  Future<void> fetchInitialData() async {
    final isLoggedIn = await _isLoggedIn();
    if (isLoggedIn) {
      // Handle user logged in
    }
  }

  Future<void> checkLogin() async {
    final isLoggedIn = await _isLoggedIn();
    if (isLoggedIn) {
      await navigator.openHomePage();
    } else {
      await navigator.openSignIn();
    }
  }

  Future<bool> _isLoggedIn() async {
    final token = await authRepo.getToken();
    final isLoggedIn = token != null;
    return isLoggedIn;
  }

  Future<bool> isLoggedIn() async {
    await Future.delayed(const Duration(seconds: 1));
    final token = await authRepo.getToken();
    final isLoggedIn = token != null;
    return isLoggedIn;
  }
}
