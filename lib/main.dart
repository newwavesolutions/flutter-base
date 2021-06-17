import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/services.dart';
import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/commons/app_themes.dart';
import 'package:flutter_base/network/api_util.dart';
import 'package:flutter_base/repositories/auth_repository.dart';
import 'package:flutter_base/repositories/movie_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'generated/l10n.dart';
import 'network/api_client.dart';
import 'repositories/user_repository.dart';
import 'router/application.dart';
import 'router/routers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(MyApp());
  //black
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
}

class MyApp extends StatefulWidget {
  MyApp() {
    final router = new FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  ApiClient _apiClient;

  @override
  void initState() {
    _apiClient = ApiUtil.instance.apiClient;
    super.initState();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(create: (context) {
          return AuthRepositoryImpl(_apiClient);
        }),
        RepositoryProvider<MovieRepository>(create: (context) {
          return MovieRepositoryImpl(_apiClient);
        }),
        RepositoryProvider<UserRepository>(create: (context) {
          return UserRepositoryImpl(_apiClient);
        }),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppCubit>(create: (context) {
            final userRepository = RepositoryProvider.of<UserRepository>(context);
            return AppCubit(
              userRepository: userRepository,
            );
          })
        ],
        child: materialApp(),
      ),
    );
  }

  MaterialApp materialApp() {
    //Setup PortraitUp only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      theme: AppThemes.theme,
      onGenerateRoute: Application.router.generator,
      initialRoute: Routes.root,
      // navigatorObservers: [
      //   NavigationObserver(context.bloc<NavigationCubit>()),
      // ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            // When running in iOS, dismiss the keyboard when any Tap happens outside a TextField
            if (Platform.isIOS) hideKeyboard(context);
          },
          child: MediaQuery(
            child: child,
            //Disable text scale depend on system's font size
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          ),
        );
      },
    );
  }

  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus.unfocus();
    }
  }
}
