import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/common/app_themes.dart';
import 'package:flutter_base/configs/app_configs.dart';
import 'package:flutter_base/global_blocs/auth/auth_cubit.dart';
import 'package:flutter_base/global_blocs/setting/app_setting_cubit.dart';
import 'package:flutter_base/global_blocs/user/user_cubit.dart';
import 'package:flutter_base/models/enums/language.dart';
import 'package:flutter_base/ui/widgets/loading/app_loading_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'generated/l10n.dart';
import 'network/api_client.dart';
import 'network/api_util.dart';
import 'repositories/auth_repository.dart';
import 'repositories/movie_repository.dart';
import 'repositories/notification_repository.dart';
import 'repositories/user_repository.dart';
import 'router/route_config.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  late ApiClient _apiClient;
  late ApiClient _apiMocKyClient;

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
          BlocProvider<AuthCubit>(create: (context) {
            final authRepo = RepositoryProvider.of<AuthRepository>(context);
            return AuthCubit(authRepo: authRepo);
          }),
          BlocProvider<UserCubit>(create: (context) {
            final userRepository =
                RepositoryProvider.of<UserRepository>(context);
            return UserCubit(userRepository: userRepository);
          }),
          BlocProvider<AppSettingCubit>(create: (context) {
            return AppSettingCubit();
          }),
        ],
        child: BlocBuilder<AppSettingCubit, AppSettingState>(
          buildWhen: (prev, current) {
            return prev.language != prev.language;
          },
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                _hideKeyboard(context);
              },
              child: GlobalLoaderOverlay(
                useDefaultLoading: false,
                overlayWidgetBuilder: (_) {
                  return Center(
                    child: Container(
                      color: Colors.grey,
                      width: 40,
                      height: 40,
                      child:
                          const Center(child: AppCircularProgressIndicator()),
                    ),
                  );
                },
                child: _buildMaterialApp(
                  locale: state.language.local,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMaterialApp({
    required Locale locale,
  }) {
    return MaterialApp.router(
      title: AppConfigs.appName,
      theme: AppThemes().theme,
      themeMode: ThemeMode.dark,
      routerConfig: AppRouter.router,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
      ],
      locale: locale,
      supportedLocales: S.delegate.supportedLocales,
    );
  }

  void _hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
