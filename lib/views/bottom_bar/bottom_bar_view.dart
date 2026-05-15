import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/constants/app_constants.dart';
import '../home/home_view.dart';

/// Bottom-navigation shell with 4 tabs.
///
/// How to wire up your own screens:
///   1. Replace each placeholder in [_pageOptions] with your real screen widget.
///   2. Update the icon and label in [_navItems] to match.
///   3. Register this view in [AppPages] and navigate to it after login.
class BottomBarView extends StatefulWidget {
  const BottomBarView({this.initialIndex = 0, super.key});

  final int initialIndex;

  @override
  State<BottomBarView> createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView> {
  late final RxInt _selectedIndex;
  bool? hasInternet;

  /// TODO: Replace each entry with the real screen for that tab.
  final List<Widget> _pageOptions = const [
    HomeView(),                           // Tab 0 — Home
    _PlaceholderTab(label: 'Messages'),   // Tab 1 — replace with MessagesView()
    _PlaceholderTab(label: 'Profile'),    // Tab 2 — replace with ProfileView()
    _PlaceholderTab(label: 'Settings'),   // Tab 3 — replace with SettingsView()
  ];

  static const _navItems = [
    _NavItem(icon: Icons.home_rounded,    label: 'Home'),
    _NavItem(icon: Icons.chat_rounded,    label: 'Messages'),
    _NavItem(icon: Icons.person_rounded,  label: 'Profile'),
    _NavItem(icon: Icons.settings_rounded,label: 'Settings'),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex.obs;
    _listenToConnectivity();
  }

  void _listenToConnectivity() {
    try {
      Connectivity().onConnectivityChanged.listen((results) {
        final connected = results.any(
          (r) => r == ConnectivityResult.wifi || r == ConnectivityResult.mobile,
        );
        if (mounted) setState(() => hasInternet = connected);
      });
    } catch (_) {
      if (mounted) setState(() => hasInternet = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: false,
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        body: hasInternet == false
            ? _NoInternetBanner(onRetry: () => setState(() {}))
            : Obx(() => _pageOptions[_selectedIndex.value]),
        bottomNavigationBar: SizedBox(
          height: Platform.isIOS ? h * .12 : kToolbarHeight * 1.2,
          child: _buildBottomBar(context),
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(() => BottomAppBar(
          color: theme.colorScheme.surface,
          elevation: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              _navItems.length,
              (i) => _buildNavItem(context, i, theme),
            ),
          ),
        ));
  }

  Widget _buildNavItem(BuildContext context, int index, ThemeData theme) {
    final selected = _selectedIndex.value == index;
    final item = _navItems[index];
    return GestureDetector(
      onTap: () => _selectedIndex.value = index,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selected
                  ? theme.colorScheme.primary.withValues(alpha: 0.12)
                  : Colors.transparent,
            ),
            child: Icon(
              item.icon,
              color: selected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.secondary,
              size: 26,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            item.label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: selected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.secondary,
              fontWeight:
                  selected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

/// Data class for bottom-nav items.
class _NavItem {
  const _NavItem({required this.icon, required this.label});
  final IconData icon;
  final String label;
}

/// Placeholder screen shown for tabs that have not been implemented yet.
class _PlaceholderTab extends StatelessWidget {
  const _PlaceholderTab({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.construction_rounded,
              size: 48, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(height: AppConstants.spacingM),
          Text(
            '$label — coming soon',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppConstants.spacingS),
          Text(
            'Replace _PlaceholderTab in bottom_bar_view.dart\nwith your real screen widget.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
        ],
      ),
    );
  }
}

/// Full-screen "no internet" banner.
class _NoInternetBanner extends StatelessWidget {
  const _NoInternetBanner({required this.onRetry});
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.wifi_off_rounded,
                size: 64, color: theme.colorScheme.secondary),
            const SizedBox(height: AppConstants.spacingL),
            Text('No Internet Connection',
                style: theme.textTheme.titleMedium,
                textAlign: TextAlign.center),
            const SizedBox(height: AppConstants.spacingS),
            Text(
              'Check your connection and try again.',
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.secondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.spacingL),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
