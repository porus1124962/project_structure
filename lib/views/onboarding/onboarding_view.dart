import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/onboarding_controller.dart';
import '../../services/constants/app_constants.dart';
import '../../widgets/custom_button.dart';


class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingL,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: controller.skip,
                  child: Text(
                    'Skip',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PageView(
                  onPageChanged: controller.onPageChanged,
                  controller: controller.pageController,
                  children: [
                    _Page(
                      icon: Icons.touch_app_rounded,
                      title: 'Welcome',
                      subtitle: 'Hint: Start by using this structure as your base.',
                    ),

                    _Page(
                      icon: Icons.people_rounded,
                      title: 'Connect',
                      subtitle: 'Hint: Keep screens, controllers, and bindings in this pattern.',
                    ),
                    _Page(
                      icon: Icons.settings_rounded,
                      title: 'You\'re set',
                      subtitle: 'Hint: Extend this structure to build features faster.',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: AppConstants.spacingL),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    OnboardingController.totalPages,
                    (i) => Obx(
                      () => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: controller.currentPage.value == i
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(
                                  context,
                                ).colorScheme.outline.withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppConstants.spacingL,
                  right: AppConstants.spacingL,
                  bottom: AppConstants.spacingL,
                ),
                child: Obx(
                  () => CustomButton(
                    label: controller.currentPage.value ==
                            OnboardingController.totalPages - 1
                        ? 'Get started'
                        : 'Next',
                    onPressed: controller.next,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Page extends StatelessWidget {
  const _Page({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 80, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: AppConstants.spacingL),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppConstants.spacingM),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
