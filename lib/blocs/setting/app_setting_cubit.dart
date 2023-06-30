import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/utils/utils.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../configs/app_configs.dart';

part 'app_setting_state.dart';

class AppSettingCubit extends Cubit<AppSettingState> with HydratedMixin {
  AppSettingCubit() : super(const AppSettingState());

  void resetSetting() {
    emit(const AppSettingState());
  }

  void changeThemeMode({required ThemeMode themeMode}) {
    emit(state.copyWith(themeMode: themeMode));
  }

  void changePrimaryColor({required Color primaryColor}) {
    emit(state.copyWith(primaryColor: primaryColor));
  }

  void changeLocal({required Locale locale}) {
    emit(state.copyWith(locale: locale));
    // Todo
    // Get.updateLocale(locale);
  }

  @override
  AppSettingState? fromJson(Map<String, dynamic> json) {
    return AppSettingState(
      themeMode: json['themeMode'] is int
          ? ThemeMode.values[json['themeMode']]
          : ThemeMode.system,
      primaryColor: json['primaryColor'] is String
          ? (Utils.getColorFromHex(json['primaryColor'] as String) ??
              AppColors.primary)
          : AppColors.primary,
      locale: json['local'] is String
          ? Locale.fromSubtags(languageCode: json['local'])
          : AppConfigs.defaultLocal,
    );
  }

  @override
  Map<String, dynamic>? toJson(AppSettingState state) {
    return {
      'themeMode': state.themeMode.index,
      'primaryColor': Utils.getHexFromColor(state.primaryColor),
      'local': state.locale.languageCode,
    };
  }
}
