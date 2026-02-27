import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


import '../routes/app_pages.dart';
import '../services/Network/API.dart';
import '../services/constants/storage_keys.dart';

class OnboardingController extends GetxController {
  final pageController = PageController();
  final RxInt currentPage = 0.obs;
  static const int totalPages = 3;

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void next() {
    if (currentPage.value < totalPages - 1) {
      pageController.nextPage(

        curve: Curves.easeInOut, duration: Duration(milliseconds: 300),
      );
    } else {
      _finish();
    }
  }

  void skip() {
    _finish();
  }

  void _finish() {
    Api.singleton.sp.write(StorageKeys.hasSeenOnboarding, true);
    Get.offAllNamed(Routes.login);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
