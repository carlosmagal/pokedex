import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:intl/intl.dart';
import 'package:pokedex_app/src/views/screens/home/home_screen.dart';

import 'config/app_config.dart';

class AppScreen extends StatefulWidget {
  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    _customInit();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // if (state == AppLifecycleState.resumed) {}
  }

  _customInit() {
    _configureAppSettings();
  }

  _configureAppSettings() {
    WidgetsBinding.instance?.addObserver(this);
    Intl.defaultLocale = 'pt_BR';
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return FlutterAppPlus(
      debugShowCheckedModeBanner: !AppConfig.getInstance().isProd,
      title: AppConfig.getInstance().appName!,
      theme: ThemeData(fontFamily: 'Poppins'),
      navigatorKey: navigatorPlus.key,
      home: _getCurrentScreen(),
    );
  }

  Widget _getCurrentScreen() {
    return HomeScreen();
  }
}
