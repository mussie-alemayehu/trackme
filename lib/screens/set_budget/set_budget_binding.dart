import 'package:get/get.dart';
import 'set_budget_controller.dart';

class SetBudgetBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SetBudgetController>(SetBudgetController());
  }
}
