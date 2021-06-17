import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/commons/app_colors.dart';
import 'package:flutter_base/repositories/auth_repository.dart';
import 'package:flutter_base/repositories/user_repository.dart';
import 'package:flutter_base/router/application.dart';
import 'package:flutter_base/router/routers.dart';
import 'package:flutter_base/ui/dialogs/app_dialog.dart';
import 'package:flutter_base/ui/pages/splash/splash_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../commons/app_colors.dart';
import '../../../commons/app_images.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  SplashCubit _cubit;
  StreamSubscription _navigationSubscription;

  @override
  void initState() {
    final authRepository = RepositoryProvider.of<AuthRepository>(context);
    final userRepository = RepositoryProvider.of<UserRepository>(context);
    final appCubit = BlocProvider.of<AppCubit>(context);
    _cubit = SplashCubit(appCubit: appCubit, authRepository: authRepository, userRepository: userRepository);
    super.initState();
    _navigationSubscription = _cubit.navigatorController.stream.listen((event) {
      switch (event) {
        case SplashNavigator.OPEN_HOME:
          showHome();
          break;
        case SplashNavigator.OPEN_SIGN_IN:
          showSignIn();
          break;
        case SplashNavigator.OPEN_LOAD_DATA_FAILURE:
          showErrorHappened();
          break;
      }
    });
    _cubit.checkLogin();
  }

  @override
  void dispose() {
    _navigationSubscription.cancel();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Center(
            child: Container(
              height: 200,
              width: 200,
              child: Image.asset(AppImages.icLogo),
            ),
          ),
        ],
      ),
    );
  }

  ///Navigate
  void showSignIn() async {
    await Application.router.navigateTo(context, Routes.signIn);
    _cubit.checkLogin();
  }

  void showHome() {
    Application.router.navigateTo(context, Routes.main);
  }

  void showErrorHappened() {
    AppDialog(
      context: context,
      type: DialogType.ERROR,
      title: "Error",
      description: "Cannot connect to server!",
      okText: "Retry",
      onOkPressed: () {
        _cubit.checkLogin();
      },
      dismissible: false,
    ).show();
  }
}
