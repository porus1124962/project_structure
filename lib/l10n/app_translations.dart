import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'translations/ar_sa.dart';
import 'translations/en_us.dart';

/// GetX translation class.
///
/// Usage anywhere in the app:
/// ```dart
/// Text('login'.tr)          // → 'Login' / 'تسجيل الدخول'
/// ```
///
/// To add a new locale:
/// 1. Create `lib/l10n/translations/fr_fr.dart` with a `frFR` map.
/// 2. Import it here and add an entry to [keys] and [supportedLocales].
/// 3. Pass a `Locale('fr', 'FR')` to [GetMaterialApp.locale] or call
///    `Get.updateLocale(const Locale('fr', 'FR'))` at runtime.
class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'ar_SA': arSA,
      };

  /// Matches [GetMaterialApp.supportedLocales].
  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('ar', 'SA'),
  ];
}

