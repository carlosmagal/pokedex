import 'app_config.dart';

mixin Environment {
  static final dev = AppConfig(
    appName: '[DEV] Pokédex',
    appEnvironment: AppEnvironment.development,
    apiBaseUrl: 'https://pokeapi.co/api/v2/',
  );
  static final prod = AppConfig(
    appName: 'Pokédex',
    appEnvironment: AppEnvironment.production,
    apiBaseUrl: 'apiProd',
  );
}
