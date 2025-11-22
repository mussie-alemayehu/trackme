import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../routes/app_pages.dart';

class SplashController extends GetxController {
  final _storage = GetStorage();

  @override
  void onReady() {
    super.onReady();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 2));

    if (_storage.read('onboarding_complete') == true) {
      Get.offNamed(Routes.HOME);
    } else {
      Get.offNamed(Routes.ONBOARDING);
    }
  }
}
