import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_dimens.dart';
import 'package:flutter_base/generated/l10n.dart';
import 'package:flutter_base/ui/widgets/appbar/app_bar_widget.dart';
import 'package:get/get.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: S.of(context).settings_title,
        onBackPressed: () {
          Get.back();
        },
      ),
      body: Container(
        padding: const EdgeInsets.all(AppDimens.paddingNormal),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            // _buildThemeSection(),
            // _buildLanguageSection(),
          ],
        ),
      ),
    );
  }

  // Widget _buildThemeSection() {
  //   final theme = Theme.of(context);
  //   return Obx(() {
  //     return Column(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           S.of(context).settings_themeMode,
  //           style: theme.textTheme.headline6,
  //         ),
  //         RadioListTile(
  //           title: Text(S.of(context).settings_themeModeSystem),
  //           value: ThemeMode.system,
  //           groupValue: settingService.currentThemeMode.value,
  //           onChanged: (ThemeMode? value) {
  //             if (value != null) {
  //               settingService.changeThemeMode(value);
  //             }
  //           },
  //         ),
  //         RadioListTile(
  //           title: Text(S.of(context).settings_themeModeLight),
  //           value: ThemeMode.light,
  //           groupValue: settingService.currentThemeMode.value,
  //           onChanged: (ThemeMode? value) {
  //             if (value != null) {
  //               settingService.changeThemeMode(value);
  //             }
  //           },
  //         ),
  //         RadioListTile(
  //           title: Text(S.of(context).settings_themeModeDark),
  //           value: ThemeMode.dark,
  //           groupValue: settingService.currentThemeMode.value,
  //           onChanged: (ThemeMode? value) {
  //             if (value != null) {
  //               settingService.changeThemeMode(value);
  //             }
  //           },
  //         ),
  //       ],
  //     );
  //   });
  //   ;
  // }
  //
  // Widget _buildLanguageSection() {
  //   final theme = Theme.of(context);
  //   print("SonLT ===== ${settingService.currentLocate.value}");
  //   return Obx(() {
  //     return Column(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           S.of(context).settings_language,
  //           style: theme.textTheme.headline6,
  //         ),
  //         RadioListTile(
  //           title: Text(S.of(context).settings_languageEnglish),
  //           value: Locale.fromSubtags(languageCode: 'en'),
  //           groupValue: settingService.currentLocate.value,
  //           onChanged: (Locale? value) {
  //             if (value != null) {
  //               settingService.updateLocale(value);
  //             }
  //           },
  //         ),
  //         RadioListTile(
  //           title: Text(S.of(context).settings_languageVietnamese),
  //           value: Locale.fromSubtags(languageCode: 'vi'),
  //           groupValue: settingService.currentLocate.value,
  //           onChanged: (Locale? value) {
  //             if (value != null) {
  //               settingService.updateLocale(value);
  //             }
  //           },
  //         ),
  //       ],
  //     );
  //   });
  // }
}
