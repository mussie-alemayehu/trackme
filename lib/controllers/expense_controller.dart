import 'package:get/get.dart';
import '../models/expense.dart';

class ExpenseController extends GetxController {
  final RxList<Expense> expenses = <Expense>[].obs;

  void addExpense(Expense expense) {
    expenses.add(expense);
  }

  void updateExpense(Expense expense) {
    final index = expenses.indexWhere((e) => e.id == expense.id);
    if (index != -1) {
      expenses[index] = expense;
    }
  }

  void deleteExpense(String id) {
    expenses.removeWhere((e) => e.id == id);
  }

  double get totalSpent => expenses.fold(0, (sum, item) => sum + item.amount);
}
