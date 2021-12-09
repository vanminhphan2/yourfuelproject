

enum Environment { dev, prod }

class AppConfig {

  static AppConfig? instance;

  final String apiBaseUrl;

  AppConfig._({required this.apiBaseUrl});

  factory AppConfig._dev() {
    return AppConfig._(apiBaseUrl: "google.com");
  }

  factory AppConfig._prod() {
    return AppConfig._(apiBaseUrl: "google.com");
  }

  static void build(Environment environment) {
    switch (environment) {
      case Environment.dev:
        instance = AppConfig._dev();
        break;
      case Environment.prod:
        instance = AppConfig._prod();
        break;
      default:
        instance = AppConfig._dev();
    }
  }
}
