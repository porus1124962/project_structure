import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/settings_controller.dart';
import '../../controllers/theme_controller.dart';
import '../../services/constants/app_constants.dart';
import '../../widgets/custom_button.dart';



class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppConstants.spacingM),
          children: [
            Text(
              'Appearance',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            const SizedBox(height: AppConstants.spacingS),
            Obx(() {
              final themeController = controller.themeController;
              return Card(
                child: SwitchListTile(
                  title: const Text('Dark mode'),
                  subtitle: Text(
                    themeController.themeMode == AppThemeMode.system
                        ? 'System'
                        : themeController.themeMode.name,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  value: themeController.isDarkMode,
                  onChanged: (_) => themeController.toggleTheme(),
                ),
              );
            }),
            const SizedBox(height: AppConstants.spacingM),
            Obx(() {
              final themeController = controller.themeController;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingS),
                child: SegmentedButton<AppThemeMode>(
                  segments: const [
                    ButtonSegment(
                      value: AppThemeMode.light,
                      icon: Icon(Icons.light_mode_rounded),
                      label: Text('Light'),
                    ),
                    ButtonSegment(
                      value: AppThemeMode.dark,
                      icon: Icon(Icons.dark_mode_rounded),
                      label: Text('Dark'),
                    ),
                    ButtonSegment(
                      value: AppThemeMode.system,
                      icon: Icon(Icons.settings_brightness_rounded),
                      label: Text('System'),
                    ),
                  ],
                  selected: {themeController.themeMode},
                  onSelectionChanged: (Set<AppThemeMode> selected) {
                    themeController.setThemeMode(selected.first);
                  },
                ),
              );
            }),
            const SizedBox(height: AppConstants.spacingL),
            Text(
              'Account',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            const SizedBox(height: AppConstants.spacingS),
            CustomButton(
              label: 'Logout',
              outlined: true,
              onPressed: controller.logout,
            ),
          ],
        ),
      ),
    );
  }
}
