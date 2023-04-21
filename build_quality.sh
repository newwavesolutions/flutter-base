flutter clean
flutter pub get
flutter pub run intl_utils:generate
flutter pub run build_runner build --delete-conflicting-outputs
flutter format ./lib --set-exit-if-changed
flutter analyze