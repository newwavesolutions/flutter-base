import 'package:flutter/material.dart';
import 'package:flutter_base/blocs/setting/app_setting_cubit.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_shadows.dart';
import 'package:flutter_base/common/app_text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeModeWidget extends StatefulWidget {
  const ThemeModeWidget({Key? key}) : super(key: key);

  @override
  State<ThemeModeWidget> createState() => _ThemeModeWidgetState();
}

class _ThemeModeWidgetState extends State<ThemeModeWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tapBarController;
  late AppSettingCubit _appSettingCubit;
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _appSettingCubit = BlocProvider.of<AppSettingCubit>(context);
    _themeMode = _appSettingCubit.state.themeMode;
    _tapBarController = TabController(
        length: 3,
        vsync: this,
        initialIndex: ThemeMode.values.indexOf(_themeMode));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(
            color: AppColors.divider,
          ),
          const SizedBox(height: 10),
          Row(
            children: const [
              Icon(Icons.light_mode_outlined),
              SizedBox(width: 10),
              Text('Theme mode', style: AppTextStyle.grey),
            ],
          ),
          const SizedBox(height: 10),
          BlocConsumer<AppSettingCubit, AppSettingState>(
            bloc: _appSettingCubit,
            listenWhen: (prev, cur) {
              return prev.themeMode != cur.themeMode;
            },
            listener: (context, state) {
              _themeMode = state.themeMode;
              _tapBarController.animateTo(ThemeMode.values.indexOf(_themeMode));
            },
            buildWhen: (prev, cur) {
              return prev.themeMode != cur.themeMode;
            },
            builder: (context, state) {
              return Container(
                height: 40,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.buttonBGWhite.withOpacity(0.6),
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                ),
                child: TabBar(
                  controller: _tapBarController,
                  tabs: ThemeMode.values.map((e) => _tabItem(e)).toList(),
                  onTap: (index) {
                    _appSettingCubit.changeThemeMode(
                        themeMode: ThemeMode.values[index]);
                  },
                  labelColor: Colors.black,
                  indicator: BoxDecoration(
                    color: AppColors.backgroundLight,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    boxShadow: AppShadow.boxShadow,
                  ),
                  indicatorWeight: 0,
                ),
              );
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _tabItem(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return const Icon(
          Icons.auto_mode,
          // color: Colors.black,
        );
      case ThemeMode.light:
        return const Icon(
          Icons.light_mode,
          // color: Colors.black,
        );
      case ThemeMode.dark:
        return const Icon(
          Icons.dark_mode_outlined,
          // color: Colors.black,
        );
    }
  }
}
