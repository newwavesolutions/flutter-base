import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/models/entities/index.dart';
import 'package:flutter_base/models/entities/user_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/auth_repository.dart';
import 'package:flutter_base/repositories/user_repository.dart';
import 'package:flutter_base/utils/logger.dart';
import 'package:rxdart/rxdart.dart';

part 'splash_state.dart';

enum SplashNavigator {
  OPEN_HOME,
  OPEN_SIGN_IN,
  OPEN_LOAD_DATA_FAILURE,
}

class SplashCubit extends Cubit<SplashState> {
  AuthRepository authRepository;
  UserRepository userRepository;
  AppCubit appCubit;

  final messageController = PublishSubject<String>();
  final navigatorController = PublishSubject<SplashNavigator>();

  SplashCubit({this.appCubit, this.authRepository, this.userRepository}) : super(SplashState());

  void checkLogin() async {
    await Future.delayed(Duration(seconds: 2));
    TokenEntity token = await authRepository.getToken();
    if (token == null) {
      logger.d('emit LOGGED_OUT');
      emit(state.copyWith(loginState: LoginState.LOGGED_OUT));
      navigatorController.sink.add(SplashNavigator.OPEN_SIGN_IN);
    } else {
      logger.d('emit LOGGED_IN');
      try {
        //Profile
        UserEntity myProfile = await userRepository.getProfile();
        appCubit.updateProfile(myProfile);
      } catch (error) {
        //Check 401
        if (error is DioError) {
          if (error.response?.statusCode == 401) {
            authRepository.removeToken();
            checkLogin();
            return;
          }
        }
        logger.e('$error');
        navigatorController.sink.add(SplashNavigator.OPEN_LOAD_DATA_FAILURE);
      }

      emit(state.copyWith(loginState: LoginState.LOGGED_IN));
      navigatorController.sink.add(SplashNavigator.OPEN_HOME);
    }
  }

  void getUser() {}

  void getRemoteConfig() {}

  @override
  Future<void> close() {
    messageController.close();
    navigatorController.close();
    return super.close();
  }
}
