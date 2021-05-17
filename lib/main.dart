import 'package:flutter/material.dart';

import 'src/app/app_screen.dart';
import 'src/app/config/app_config.dart';
import 'src/app/config/environments.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppConfig.getInstance(config: Environment.dev);

  runApp(AppScreen());
}
