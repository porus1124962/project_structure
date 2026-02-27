import 'package:get/get.dart';

import '../routes/app_pages.dart';


class HomeController extends GetxController {
  void openSettings() {
    Get.toNamed(Routes.settings);
  }
}
