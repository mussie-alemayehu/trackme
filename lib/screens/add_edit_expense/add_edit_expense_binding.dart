import 'package:get/get.dart';
import 'add_edit_expense_controller.dart';

class AddEditExpenseBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AddEditExpenseController>(AddEditExpenseController());
  }
}
