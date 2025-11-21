import 'package:get/get.dart';
import '../../routes/app_pages.dart';

class OnboardingController extends GetxController {
  void completeOnboarding() {
    Get.offAllNamed(Routes.HOME);
  }
}
