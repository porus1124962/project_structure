part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const splash = _Paths.splash;
  static const onboarding = _Paths.onboarding;
  static const login = _Paths.login;
  static const home = _Paths.home;
  static const settings = _Paths.settings;
}

abstract class _Paths {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const home = '/home';
  static const settings = '/settings';
}
