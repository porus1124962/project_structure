/// GetStorage keys used across the app.
abstract class StorageKeys {
  StorageKeys._();

  static const String themeMode = 'theme_mode';
  static const String hasSeenOnboarding = 'has_seen_onboarding';
  static const String token = 'token';
  static const String email = 'email';
  static const String isInductory = 'isInductory';

  // ⚠️  Never store passwords in plain local storage.
  // Use flutter_secure_storage for any sensitive credentials:
  //   https://pub.dev/packages/flutter_secure_storage
}
