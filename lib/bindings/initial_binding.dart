import 'package:get/get.dart';
import '../controllers/budget_controller.dart';
import '../controllers/expense_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BudgetController(), permanent: true);
    Get.put(ExpenseController(), permanent: true);
  }
}
