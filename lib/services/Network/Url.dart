abstract class BaseConfig {
  String get apiUrl;
  String get imageUrl;
  String get baseUrl;
  String get socketUrl;
  // String get alterEgoSocketUrl;
  String get dummyProfile;
}

class DevConfig implements BaseConfig {
  @override
  String get baseUrl => "http://123.117.128.19:8098/api/";
  @override
  String get imageUrl => "http://123.117.128.19:8098/uploads/";

  @override
  String get apiUrl => "http://123.117.128.19:8098/api/";

  @override
  String get socketUrl => "http://123.117.128.19:8098";
  @override
  // String get alterEgoSocketUrl => "ws://123.168.5.251:8092/alter-ego";
  @override
  String get dummyProfile =>
      "https://www.itdp.org/wp-content/uploads/2021/06/avatar-man-icon-profile-placeholder-260nw-1229859850-e1623694994111.jpg";
}

class ProductionConfig implements BaseConfig {
  @override
  String get baseUrl => "http://123.117.128.19:8098/";

  @override
  String get imageUrl => "http://123.117.128.19:8098/uploads/";
  @override
  String get apiUrl => "http://123.117.128.19:8098/api/";
  @override
  String get socketUrl => "http://123.117.128.19:8098";

  @override
  String get dummyProfile =>
      "https://www.itdp.org/wp-content/uploads/2021/06/avatar-man-icon-profile-placeholder-260nw-1229859850-e1623694994111.jpg";
}

class Environment {
  factory Environment() {
    return _singleton;
  }

  Environment._internal();
  static final Environment _singleton = Environment._internal();

  static const String dev = 'dev';
  static const String production = 'production';

  late BaseConfig config;

  initConfig(String environment) {
    config = _getConfig(environment);
  }

  BaseConfig _getConfig(String environment) {
    switch (environment) {
      case Environment.production:
        return ProductionConfig();
      default:
        return DevConfig();
    }
  }
}
