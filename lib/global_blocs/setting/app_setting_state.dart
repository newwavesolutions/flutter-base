part of 'app_setting_cubit.dart';

class AppSettingState extends Equatable {
  final Language language;

  const AppSettingState({
    this.language = AppConfigs.defaultLanguage,
  });

  @override
  List<Object?> get props => [
        language,
      ];

  AppSettingState copyWith({
    Language? language,
  }) {
    return AppSettingState(
      language: language ?? this.language,
    );
  }
}
