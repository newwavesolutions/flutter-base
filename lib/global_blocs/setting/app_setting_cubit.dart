import 'package:equatable/equatable.dart';
import 'package:flutter_base/configs/app_configs.dart';
import 'package:flutter_base/database/share_preferences_helper.dart';
import 'package:flutter_base/models/enums/language.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_setting_state.dart';

class AppSettingCubit extends Cubit<AppSettingState> {
  AppSettingCubit() : super(const AppSettingState());

  Future<void> getInitialSetting() async {
    final currentLanguage = await SharedPreferencesHelper.getCurrentLanguage();
    emit(state.copyWith(
      language: currentLanguage,
    ));
  }

  void changeLanguage({required Language language}) async {
    await SharedPreferencesHelper.setCurrentLanguage(language);
    emit(state.copyWith(
      language: language,
    ));
  }
}
