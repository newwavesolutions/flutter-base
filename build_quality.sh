fvm flutter clean
fvm flutter pub get
fvm flutter pub run intl_utils:generate
fvm flutter pub run build_runner build --delete-conflicting-outputs
fvm dart format ./lib --set-exit-if-changed
fvm flutter analyze