import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../services/constants/storage_keys.dart';
import '../theme/dark_theme.dart';
import '../theme/light_theme.dart';


enum AppThemeMode { light, dark, system }

class ThemeController extends GetxController {
  static ThemeController get to => Get.find<ThemeController>();

  final GetStorage _storage = GetStorage();
  final Rx<AppThemeMode> _themeMode = AppThemeMode.system.obs;

  AppThemeMode get themeMode => _themeMode.value;
  bool get isDarkMode => _resolvedBrightness == Brightness.dark;

  Brightness get _resolvedBrightness {
    if (_themeMode.value == AppThemeMode.system) {
      return WidgetsBinding.instance.platformDispatcher.platformBrightness;
    }
    return _themeMode.value == AppThemeMode.dark ? Brightness.dark : Brightness.light;
  }

  ThemeData get currentTheme =>
      _resolvedBrightness == Brightness.dark ? darkTheme : lightTheme;

  ThemeMode get themeModeForMaterial {
    switch (_themeMode.value) {
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  @override
  void onInit() {
    super.onInit();
    _loadSavedTheme();
    // Defer theme change to avoid setState() during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.changeThemeMode(themeModeForMaterial);
    });
  }

  void _loadSavedTheme() {
    final saved = _storage.read<String>(StorageKeys.themeMode);
    if (saved != null) {
      _themeMode.value = AppThemeMode.values.firstWhere(
        (e) => e.name == saved,
        orElse: () => AppThemeMode.system,
      );
    }
  }

  void setThemeMode(AppThemeMode mode) {
    _themeMode.value = mode;
    _storage.write(StorageKeys.themeMode, mode.name);
    Get.changeThemeMode(themeModeForMaterial);
  }


  void toggleTheme() {
    final next = _themeMode.value == AppThemeMode.dark
        ? AppThemeMode.light
        : AppThemeMode.dark;
    setThemeMode(next);
  }
}
