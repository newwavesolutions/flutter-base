import 'package:flutter/material.dart';
import 'package:flutter_base/blocs/setting/app_setting_cubit.dart';
import 'package:flutter_base/common/app_dimens.dart';
import 'package:flutter_base/generated/l10n.dart';
import 'package:flutter_base/ui/pages/setting/setting_cubit.dart';
import 'package:flutter_base/ui/widgets/appbar/app_bar_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SettingCubit();
      },
      child: const SettingChildPage(),
    );
  }
}

class SettingChildPage extends StatefulWidget {
  const SettingChildPage({Key? key}) : super(key: key);

  @override
  State<SettingChildPage> createState() => _SettingChildPageState();
}

class _SettingChildPageState extends State<SettingChildPage> {
  late AppSettingCubit _appSettingCubit;

  @override
  void initState() {
    _appSettingCubit = BlocProvider.of<AppSettingCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: S.of(context).settings_title,
        onBackPressed: () {
          GoRouter.of(context).pop();
        },
      ),
      body: Container(
        padding: const EdgeInsets.all(AppDimens.paddingNormal),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildThemeSection(),
            _buildLanguageSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeSection() {
    return BlocBuilder<AppSettingCubit, AppSettingState>(
      buildWhen: (prev, current) {
        return prev.themeMode != current.themeMode;
      },
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).settings_themeMode,
            ),
            RadioListTile(
              title: Text(S.of(context).settings_themeModeSystem),
              value: ThemeMode.system,
              groupValue: state.themeMode,
              onChanged: (ThemeMode? value) {
                if (value != null) {
                  _appSettingCubit.changeThemeMode(themeMode: value);
                }
              },
            ),
            RadioListTile(
              title: Text(S.of(context).settings_themeModeLight),
              value: ThemeMode.light,
              groupValue: state.themeMode,
              onChanged: (ThemeMode? value) {
                if (value != null) {
                  _appSettingCubit.changeThemeMode(themeMode: value);
                }
              },
            ),
            RadioListTile(
              title: Text(S.of(context).settings_themeModeDark),
              value: ThemeMode.dark,
              groupValue: state.themeMode,
              onChanged: (ThemeMode? value) {
                if (value != null) {
                  _appSettingCubit.changeThemeMode(themeMode: value);
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildLanguageSection() {
    return BlocBuilder<AppSettingCubit, AppSettingState>(
      buildWhen: (prev, current) {
        return prev.locale != current.locale;
      },
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).settings_language,
            ),
            RadioListTile(
              title: Text(S.of(context).settings_languageEnglish),
              value: const Locale.fromSubtags(languageCode: 'en'),
              groupValue: state.locale,
              onChanged: (Locale? value) {
                if (value != null) {
                  _appSettingCubit.changeLocal(locale: value);
                }
              },
            ),
            RadioListTile(
              title: Text(S.of(context).settings_languageVietnamese),
              value: const Locale.fromSubtags(languageCode: 'vi'),
              groupValue: state.locale,
              onChanged: (Locale? value) {
                if (value != null) {
                  _appSettingCubit.changeLocal(locale: value);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
