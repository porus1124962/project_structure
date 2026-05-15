import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../services/constants/app_constants.dart';

/// Alternative image-based intro / carousel screen.
///
/// This is an optional alternative to [OnboardingView].
/// To use it instead, register it in [AppPages] and update [SplashController].
///
/// Replace the asset paths and copy text with your own content.
class IntroView extends StatefulWidget {
  const IntroView({Key? key}) : super(key: key);

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  int _pageIndex = 0;

  static const _pages = [
    _IntroPage(
      image: 'assets/images/intro_image/stImage.jpg',
      title: 'Welcome',
      description: 'Briefly describe your app\'s main value proposition here.',
    ),
    _IntroPage(
      image: 'assets/images/intro_image/stImage.jpg',
      title: 'Stay Connected',
      description: 'Explain the key feature or benefit of your app on this slide.',
    ),
    _IntroPage(
      image: 'assets/images/intro_image/stImage.jpg',
      title: 'Get Started',
      description: 'Wrap up the intro and invite the user to create an account.',
    ),
  ];

  void _next() {
    if (_pageIndex < _pages.length - 1) {
      setState(() => _pageIndex++);
    } else {
      _finish();
    }
  }

  void _finish() => Get.offAllNamed(Routes.login);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final page = _pages[_pageIndex];
    final isLast = _pageIndex == _pages.length - 1;

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        child: _buildPage(context, theme, page, isLast),
      ),
    );
  }

  Widget _buildPage(
      BuildContext context, ThemeData theme, _IntroPage page, bool isLast) {
    return Stack(
      key: ValueKey(_pageIndex),
      fit: StackFit.expand,
      children: [
        // Background image
        Image.asset(page.image, fit: BoxFit.cover),

        // Skip button
        Positioned(
          right: AppConstants.spacingM,
          top: MediaQuery.of(context).padding.top + AppConstants.spacingS,
          child: TextButton(
            onPressed: _finish,
            child: Text(
              'Skip',
              style: theme.textTheme.labelLarge
                  ?.copyWith(color: Colors.white, shadows: [
                const Shadow(blurRadius: 4, color: Colors.black45),
              ]),
            ),
          ),
        ),

        // Bottom overlay panel
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.fromLTRB(
              AppConstants.spacingL,
              AppConstants.spacingL,
              AppConstants.spacingL,
              AppConstants.spacingXl,
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface.withValues(alpha: 0.92),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppConstants.radiusL),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Page indicators
                Row(
                  children: List.generate(
                    _pages.length,
                    (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.only(right: 6),
                      width: _pageIndex == i ? 20 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _pageIndex == i
                            ? theme.colorScheme.primary
                            : theme.colorScheme.outline,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppConstants.spacingM),
                Text(page.title, style: theme.textTheme.headlineMedium),
                const SizedBox(height: AppConstants.spacingS),
                Text(
                  page.description,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: theme.colorScheme.secondary),
                ),
                const SizedBox(height: AppConstants.spacingL),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _next,
                    child: Text(isLast ? 'Get Started' : 'Next'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _IntroPage {
  const _IntroPage({
    required this.image,
    required this.title,
    required this.description,
  });

  final String image;
  final String title;
  final String description;
}
