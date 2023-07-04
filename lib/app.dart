import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/configs/app_configs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'blocs/app_cubit.dart';
import 'blocs/setting/app_setting_cubit.dart';
import 'common/app_themes.dart';
import 'generated/l10n.dart';
import 'network/api_client.dart';
import 'network/api_util.dart';
import 'repositories/auth_repository.dart';
import 'repositories/movie_repository.dart';
import 'repositories/notification_respository.dart';
import 'repositories/user_repository.dart';
import 'router/route_config.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  late ApiClient _apiClient;
  late ApiClient _apiMocKyClient;
  final appRoutes = AppRouter();

  @override
  void initState() {
    _apiClient = ApiUtil.apiClient;
    _apiMocKyClient = ApiUtil.mocKyApiClient;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Setup PortraitUp only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(create: (context) {
          return AuthRepositoryImpl(apiClient: _apiClient);
        }),
        RepositoryProvider<MovieRepository>(create: (context) {
          return MovieRepositoryImpl(apiClient: _apiClient);
        }),
        RepositoryProvider<UserRepository>(create: (context) {
          return UserRepositoryImpl(apiClient: _apiClient);
        }),
        RepositoryProvider<NotificationRepository>(create: (context) {
          return NotificationRepositoryImpl(apiClient: _apiMocKyClient);
        }),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppCubit>(create: (context) {
            final userRepo = RepositoryProvider.of<UserRepository>(context);
            final authRepo = RepositoryProvider.of<AuthRepository>(context);
            return AppCubit(
              userRepo: userRepo,
              authRepo: authRepo,
            );
          }),
          BlocProvider<AppSettingCubit>(create: (context) {
            return AppSettingCubit();
          }),
        ],
        child: BlocBuilder<AppSettingCubit, AppSettingState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                _hideKeyboard(context);
              },
              child: MaterialApp.router(
                title: AppConfigs.appName,
                theme: AppThemes(
                  isDarkMode: false,
                  primaryColor: state.primaryColor,
                ).theme,
                //Disabled
                // darkTheme: AppThemes(
                //   isDarkMode: true,
                //   primaryColor: state.primaryColor,
                // ).theme,
                themeMode: state.themeMode,
                routeInformationParser: appRoutes.goRouter.routeInformationParser,
                routerDelegate: appRoutes.goRouter.routerDelegate,
                routeInformationProvider: appRoutes.goRouter.routeInformationProvider,
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  S.delegate,
                ],
                locale: state.locale,
                supportedLocales: S.delegate.supportedLocales,
              ),
            );
          },
        ),
      ),
    );
  }

  void _hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
