import 'package:get/get.dart';
import '../../models/expense.dart';
import '../../routes/app_pages.dart';
import '../../controllers/expense_controller.dart';

class ExpenseListController extends GetxController {
  final ExpenseController _expenseController = Get.find();

  RxList<Expense> get expenses => _expenseController.expenses;

  void deleteExpense(String id) {
    _expenseController.deleteExpense(id);
  }

  void editExpense(Expense expense) {
    Get.toNamed(Routes.EDIT_EXPENSE, arguments: expense);
  }

  void goToAddExpense() {
    Get.toNamed(Routes.ADD_EXPENSE);
  }
}
