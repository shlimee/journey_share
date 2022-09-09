import 'package:journey_share/config/enviroments/base_enviroment_config.dart';
import 'package:journey_share/config/enviroments/dev_enviroment_config.dart';

class Environment {
  factory Environment() {
    return _singleton;
  }

  Environment._internal();

  static final Environment _singleton = Environment._internal();

  static const String DEV = 'DEV';
  static const String STAGING = 'STAGING';
  static const String PROD = 'PROD';

  BaseEnviromentConfig? config;

  initConfig(String environment) {
    config = _getConfig(environment);
  }

  BaseEnviromentConfig _getConfig(String environment) {
    switch (environment) {
      default:
        return DevEnviromentConfig();
    }
  }
}
