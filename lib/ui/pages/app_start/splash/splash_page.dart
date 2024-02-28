import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_images.dart';
import 'package:flutter_base/database/share_preferences_helper.dart';
import 'package:flutter_base/global_blocs/setting/app_setting_cubit.dart';
import 'package:flutter_base/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_cubit.dart';
import 'splash_navigator.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SplashCubit(
          navigator: SplashNavigator(context: context),
          authRepo: RepositoryProvider.of<AuthRepository>(context),
        );
      },
      child: const SplashChildPage(),
    );
  }
}

class SplashChildPage extends StatefulWidget {
  const SplashChildPage({super.key});

  @override
  State<SplashChildPage> createState() => _SplashChildPageState();
}

class _SplashChildPageState extends State<SplashChildPage> {
  late SplashCubit _cubit;
  late AppSettingCubit _appSettingCubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<SplashCubit>();
    _appSettingCubit = context.read<AppSettingCubit>();
    _setup();
  }

  void _setup() async {
    await Future.delayed(const Duration(seconds: 1));
    await _requestPermissions();
    await _appSettingCubit.getInitialSetting();
    await _runOnboardingIfNeed();
    await _cubit.fetchInitialData();
    await _cubit.checkLogin();
  }

  Future<void> _requestPermissions() async {
    //Request push notification permission if need
  }

  Future<void> _runOnboardingIfNeed() async {
    final isOnboarded = await SharedPreferencesHelper.isOnboarded();
    if (!isOnboarded) {
      await _cubit.navigator.openOnboardingPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Container(color: AppColors.primary)),
          Center(
            child: Image.asset(
              AppImages.icLogoTransparent,
              width: 200,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
