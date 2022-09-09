import 'package:journey_share/config/enviroments/base_enviroment_config.dart';

class DevEnviromentConfig extends BaseEnviromentConfig {
  @override
  // TODO: implement apiUrl
  String get apiUrl => "http://localhost:3333/";

  @override
  // TODO: implement appName
  String get appName => "DEVELOPMENT MODE";
}
