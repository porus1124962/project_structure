import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'l10n/app_translations.dart';
import 'routes/app_pages.dart';
import 'theme/light_theme.dart';
import 'theme/dark_theme.dart';
import 'bindings/initial_binding.dart';
import 'services/Network/Url.dart';
import 'services/error_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Catch all unhandled Flutter & platform errors.
  ErrorHandler.init();

  await GetStorage.init();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: Environment.dev,
  );
  Environment().initConfig(environment);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My App', // TODO: replace with your app name
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),

      // ── Theme ─────────────────────────────────────────────────────────────
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,

      // ── Localisation ──────────────────────────────────────────────────────
      translations: AppTranslations(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppTranslations.supportedLocales,

      // ── Routing ───────────────────────────────────────────────────────────
      getPages: AppPages.routes,
      initialRoute: AppPages.initial,

      // ── Toasts ────────────────────────────────────────────────────────────
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
    );
  }
}
