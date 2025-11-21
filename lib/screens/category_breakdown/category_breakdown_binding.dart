import 'package:get/get.dart';
import 'category_breakdown_controller.dart';
import '../expense_list/expense_list_controller.dart';

class CategoryBreakdownBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ExpenseListController>()) {
      Get.put(ExpenseListController());
    }
    Get.put<CategoryBreakdownController>(CategoryBreakdownController());
  }
}
