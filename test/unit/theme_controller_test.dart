import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:project_structure/controllers/theme_controller.dart';

import '../helpers/app_test_helper.dart';

void main() {
  setUpAll(initTestDependencies);
  tearDown(Get.reset);

  // Build a minimal GetMaterialApp so Get.changeThemeMode() and
  // WidgetsBinding.addPostFrameCallback() have a running context.
  Widget _buildApp() => GetMaterialApp(
        initialBinding: BindingsBuilder(() {
          Get.lazyPut<ThemeController>(() => ThemeController(), fenix: true);
        }),
        home: const Scaffold(body: SizedBox.shrink()),
      );

  group('ThemeController', () {
    testWidgets('initial themeMode is system', (tester) async {
      await tester.pumpWidget(_buildApp());
      await tester.pump();
      expect(Get.find<ThemeController>().themeMode, AppThemeMode.system);
    });

    testWidgets('setThemeMode updates themeMode', (tester) async {
      await tester.pumpWidget(_buildApp());
      await tester.pump();

      final c = Get.find<ThemeController>();
      c.setThemeMode(AppThemeMode.dark);
      expect(c.themeMode, AppThemeMode.dark);

      c.setThemeMode(AppThemeMode.light);
      expect(c.themeMode, AppThemeMode.light);
    });

    testWidgets('toggleTheme switches between light and dark', (tester) async {
      await tester.pumpWidget(_buildApp());
      await tester.pump();

      final c = Get.find<ThemeController>();
      c.setThemeMode(AppThemeMode.light);

      c.toggleTheme();
      expect(c.themeMode, AppThemeMode.dark);

      c.toggleTheme();
      expect(c.themeMode, AppThemeMode.light);
    });

    testWidgets('isDarkMode returns true when dark theme is active',
        (tester) async {
      await tester.pumpWidget(_buildApp());
      await tester.pump();

      final c = Get.find<ThemeController>();
      c.setThemeMode(AppThemeMode.dark);
      expect(c.isDarkMode, isTrue);
    });
  });
}

