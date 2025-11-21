import 'package:get/get.dart';
import 'expense_list_controller.dart';

class ExpenseListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ExpenseListController>(ExpenseListController());
  }
}
