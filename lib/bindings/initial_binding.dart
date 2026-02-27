import 'package:get/get.dart';

import '../controllers/theme_controller.dart';


/// Global bindings (theme, auth, etc.) used at app start.
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThemeController>(() => ThemeController(), fenix: true);
  }
}
