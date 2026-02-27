import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';



import '../routes/app_pages.dart';
import '../services/Network/API.dart';
import '../services/constants/storage_keys.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    final hasSeenOnboarding = Api.singleton.sp.read(StorageKeys.hasSeenOnboarding) == true;
    final hasAuth = Api.singleton.sp.read(StorageKeys.token) != null;
    print("Init function");
    if (!hasSeenOnboarding) {
      Get.offAllNamed(Routes.onboarding);
    } else if (!hasAuth) {
      Get.offAllNamed(Routes.login);
    } else {
      print("home page is here");
      Get.offAllNamed(Routes.home);
    }
  }
}
