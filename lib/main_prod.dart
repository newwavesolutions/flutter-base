import 'package:flutter/material.dart';

import 'app.dart';
import 'configs/app_configs.dart';
import 'configs/app_env_config.dart';

void main() async {
  AppConfigs.env = Environment.prod;
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
