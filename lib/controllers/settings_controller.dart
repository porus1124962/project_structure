import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_structure/controllers/theme_controller.dart';



import '../routes/app_pages.dart';
import '../services/Network/API.dart';
import '../services/constants/storage_keys.dart';

class SettingsController extends GetxController {
  ThemeController get themeController => ThemeController.to;

  void logout() {
    Api.singleton.sp.remove(StorageKeys.token);
    Get.offAllNamed(Routes.login);
  }
}
