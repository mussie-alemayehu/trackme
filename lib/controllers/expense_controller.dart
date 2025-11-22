import 'package:get/get.dart';
import '../models/expense.dart';
import '../services/database_service.dart';

class ExpenseController extends GetxController {
  final RxList<Expense> expenses = <Expense>[].obs;
  final DatabaseService _databaseService = DatabaseService();

  @override
  void onInit() {
    super.onInit();
    _loadExpenses();
  }

  Future<void> _loadExpenses() async {
    final loadedExpenses = await _databaseService.getExpenses();
    expenses.assignAll(loadedExpenses);
  }

  void addExpense(Expense expense) {
    expenses.add(expense);
    _databaseService.insertExpense(expense);
  }

  void updateExpense(Expense expense) {
    final index = expenses.indexWhere((e) => e.id == expense.id);
    if (index != -1) {
      expenses[index] = expense;
      _databaseService.updateExpense(expense);
    }
  }

  void deleteExpense(String id) {
    expenses.removeWhere((e) => e.id == id);
    _databaseService.deleteExpense(id);
  }

  double get totalSpent => expenses.fold(0, (sum, item) => sum + item.amount);
}
