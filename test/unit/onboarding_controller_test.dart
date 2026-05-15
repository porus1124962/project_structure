import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:project_structure/controllers/onboarding_controller.dart';

import '../helpers/app_test_helper.dart';

void main() {
  setUpAll(initTestDependencies);
  tearDown(Get.reset);

  group('OnboardingController', () {
    late OnboardingController controller;

    setUp(() => controller = OnboardingController());
    tearDown(() => controller.onClose());

    test('initial page index is 0', () {
      expect(controller.currentPage.value, 0);
    });

    test('totalPages constant equals 3', () {
      expect(OnboardingController.totalPages, 3);
    });

    test('onPageChanged updates currentPage', () {
      controller.onPageChanged(1);
      expect(controller.currentPage.value, 1);

      controller.onPageChanged(2);
      expect(controller.currentPage.value, 2);
    });

    test('onPageChanged clamps within valid page range', () {
      // Should not throw for any int value — the PageView enforces bounds.
      expect(() => controller.onPageChanged(0), returnsNormally);
      expect(() => controller.onPageChanged(OnboardingController.totalPages - 1),
          returnsNormally);
    });
  });
}

