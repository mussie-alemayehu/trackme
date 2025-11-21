import 'package:get/get.dart';
import '../../controllers/budget_controller.dart';
import '../../controllers/expense_controller.dart';
import '../../routes/app_pages.dart';
import '../../models/budget.dart';

class HomeController extends GetxController {
  final BudgetController _budgetController = Get.find();
  final ExpenseController _expenseController = Get.find();

  double get budget => _budgetController.totalAmount;
  double get totalSpent => _expenseController.totalSpent;
  double get remaining => budget - totalSpent;

  // For reactivity
  Rx<Budget> get budgetRx => _budgetController.budget;
  get expensesRx => _expenseController.expenses;

  void goToSetBudget() => Get.toNamed(Routes.SET_BUDGET);
  void goToExpenses() => Get.toNamed(Routes.EXPENSE_LIST);
  void goToBreakdown() => Get.toNamed(Routes.CATEGORY_BREAKDOWN);
}
