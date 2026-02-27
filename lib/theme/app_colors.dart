import 'package:flutter/material.dart';

/// Centralized color system for light and dark themes.
abstract class AppColors {
  AppColors._();

  // Light theme
  static const Color primaryLight = Color(0xFF2563EB);
  static const Color secondaryLight = Color(0xFF64748B);
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color errorLight = Color(0xFFDC2626);
  static const Color onPrimaryLight = Color(0xFFFFFFFF);
  static const Color onSecondaryLight = Color(0xFFFFFFFF);
  static const Color onBackgroundLight = Color(0xFF0F172A);
  static const Color onSurfaceLight = Color(0xFF1E293B);
  static const Color onErrorLight = Color(0xFFFFFFFF);
  static const Color outlineLight = Color(0xFFE2E8F0);

  // Dark theme
  static const Color primaryDark = Color(0xFF3B82F6);
  static const Color secondaryDark = Color(0xFF94A3B8);
  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color surfaceDark = Color(0xFF1E293B);
  static const Color errorDark = Color(0xFFEF4444);
  static const Color onPrimaryDark = Color(0xFFFFFFFF);
  static const Color onSecondaryDark = Color(0xFFFFFFFF);
  static const Color onBackgroundDark = Color(0xFFF1F5F9);
  static const Color onSurfaceDark = Color(0xFFE2E8F0);
  static const Color onErrorDark = Color(0xFFFFFFFF);
  static const Color outlineDark = Color(0xFF334155);
}
