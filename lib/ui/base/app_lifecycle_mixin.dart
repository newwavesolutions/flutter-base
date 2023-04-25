import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin AppLifecycleMixin<T extends StatefulWidget> on State<T> {
  late StreamSubscription<AppLifecycleState> _appLifecycleState;

  @override
  void initState() {
    super.initState();
    final appCubit = BlocProvider.of<AppCubit>(context);

    _appLifecycleState = appCubit.appLifeCycleState.listen(
      (state) {
        switch (state) {
          case AppLifecycleState.inactive:
            onInactive();
            break;
          case AppLifecycleState.paused:
            onPaused();
            break;
          case AppLifecycleState.resumed:
            onResumed();
            break;
          case AppLifecycleState.detached:
            onDetached();
            break;
        }
      },
    );
  }

  @override
  void dispose() {
    _appLifecycleState.cancel();
    super.dispose();
  }

  @mustCallSuper
  void onInactive() {
    logger.i('[$runtimeType] did change app lifecycle state '
        '[AppLifecycleState.inactive]');
  }

  @mustCallSuper
  void onPaused() {
    logger.i('[$runtimeType] did change app lifecycle state '
        '[AppLifecycleState.paused]');
  }

  @mustCallSuper
  void onResumed() {
    logger.i('[$runtimeType] did change app lifecycle state '
        '[AppLifecycleState.resumed]');
  }

  @mustCallSuper
  void onDetached() {
    logger.i('[$runtimeType] did change app lifecycle state '
        '[AppLifecycleState.detached]');
  }
}
