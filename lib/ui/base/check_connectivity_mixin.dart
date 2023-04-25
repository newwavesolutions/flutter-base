import 'dart:async';

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin CheckConnectivityMixin<T extends StatefulWidget> on State<T> {
  late StreamSubscription<ConnectivityResult> _appConnectivity;

  @override
  void initState() {
    super.initState();
    final appCubit = BlocProvider.of<AppCubit>(context);
    _appConnectivity = appCubit.connectivityChanged
        .asBroadcastStream()
        .listen(_handleConnectivityResult);
  }

  void _handleConnectivityResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.bluetooth:
        logger.i('[$runtimeType] did change connectivity state '
            '[ConnectivityResult.bluetooth]');
        break;
      case ConnectivityResult.wifi:
        logger.i('[$runtimeType] did change connectivity state '
            '[ConnectivityResult.wifi]');
        break;
      case ConnectivityResult.ethernet:
        logger.i('[$runtimeType] did change connectivity state '
            '[ConnectivityResult.ethernet]');
        break;
      case ConnectivityResult.mobile:
        logger.i('[$runtimeType] did change connectivity state '
            '[ConnectivityResult.mobile]');
        break;
      case ConnectivityResult.vpn:
        logger.i('[$runtimeType] did change connectivity state '
            '[ConnectivityResult.vpn]');
        break;
      case ConnectivityResult.other:
        logger.i('[$runtimeType] did change connectivity state '
            '[ConnectivityResult.other]');
        break;
      case ConnectivityResult.none:
        logger.i('[$runtimeType] did change connectivity state '
            '[ConnectivityResult.none]');
        break;
    }
  }

  @override
  void dispose() {
    _appConnectivity.cancel();
    super.dispose();
  }
}
