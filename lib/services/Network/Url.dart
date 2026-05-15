abstract class BaseConfig {
  String get apiUrl;
  String get imageUrl;
  String get baseUrl;
  String get socketUrl;
  String get dummyProfile;
}

class DevConfig implements BaseConfig {
  @override
  String get baseUrl => "https://dev-api.example.com/";
  @override
  String get imageUrl => "https://dev-api.example.com/uploads/";

  @override
  String get apiUrl => "https://dev-api.example.com/api/";

  @override
  String get socketUrl => "https://dev-api.example.com";

  @override
  String get dummyProfile =>
      "https://ui-avatars.com/api/?background=random&name=User";
}

class ProductionConfig implements BaseConfig {
  @override
  String get baseUrl => "https://api.example.com/";

  @override
  String get imageUrl => "https://api.example.com/uploads/";
  @override
  String get apiUrl => "https://api.example.com/api/";
  @override
  String get socketUrl => "https://api.example.com";

  @override
  String get dummyProfile =>
      "https://ui-avatars.com/api/?background=random&name=User";
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

  void initConfig(String environment) {
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
