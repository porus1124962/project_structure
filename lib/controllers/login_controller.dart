import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


import '../routes/app_pages.dart';
import '../services/Network/API.dart';
import '../services/constants/storage_keys.dart';

class LoginController extends GetxController {
  final RxBool obscurePassword = true.obs;

  void togglePasswordVisibility() {
    obscurePassword.toggle();
  }

  void login() {
    Api.singleton.sp.write(StorageKeys.token, 'demo_token');
    Get.offAllNamed(Routes.home);
  }
}
