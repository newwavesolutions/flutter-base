import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/app.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'flavors.dart';

void main() async {
  F.appFlavor = Flavor.PROD;
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getTemporaryDirectory());
  HydratedBlocOverrides.runZoned(
    () => runApp(const MyApp()),
    storage: storage,
  );
}
