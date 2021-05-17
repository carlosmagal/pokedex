import 'app_config.dart';

mixin Environment {
  static final dev = AppConfig(
    appName: '[DEV] Pokédex',
    appEnvironment: AppEnvironment.development,
    apiBaseUrl: '',
  );
}
