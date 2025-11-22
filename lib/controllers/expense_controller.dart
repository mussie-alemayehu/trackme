import 'package:get/get.dart';
import '../models/expense.dart';
import '../services/database_service.dart';

class ExpenseController extends GetxController {
  final RxList<Expense> expenses = <Expense>[].obs;
  final DatabaseService _databaseService = DatabaseService();

  @override
  void onInit() {
    super.onInit();
    _loadExpenses().then((_) {
      if (expenses.isEmpty) {
        expenses.addAll([
          Expense(
            id: '1',
            title: 'Weekly Groceries',
            amount: 125.50,
            date: DateTime.now().subtract(const Duration(days: 1)),
            category: 'Food',
          ),
          Expense(
            id: '2',
            title: 'Netflix Subscription',
            amount: 15.99,
            date: DateTime.now().subtract(const Duration(days: 3)),
            category: 'Entertainment',
          ),
          Expense(
            id: '3',
            title: 'Gas Station',
            amount: 45.00,
            date: DateTime.now().subtract(const Duration(days: 5)),
            category: 'Transport',
          ),
          Expense(
            id: '4',
            title: 'Gym Membership',
            amount: 30.00,
            date: DateTime.now().subtract(const Duration(days: 10)),
            category: 'Health',
          ),
          Expense(
            id: '5',
            title: 'Electric Bill',
            amount: 85.20,
            date: DateTime.now().subtract(const Duration(days: 12)),
            category: 'Utilities',
          ),
          Expense(
            id: '6',
            title: 'Coffee with Friends',
            amount: 12.50,
            date: DateTime.now().subtract(const Duration(days: 2)),
            category: 'Food',
          ),
          Expense(
            id: '7',
            title: 'New T-Shirt',
            amount: 25.00,
            date: DateTime.now().subtract(const Duration(days: 7)),
            category: 'Shopping',
          ),
          Expense(
            id: '8',
            title: 'Uber Ride',
            amount: 18.75,
            date: DateTime.now().subtract(const Duration(days: 4)),
            category: 'Transport',
          ),
          Expense(
            id: '9',
            title: 'Internet Bill',
            amount: 60.00,
            date: DateTime.now().subtract(const Duration(days: 15)),
            category: 'Utilities',
          ),
          Expense(
            id: '10',
            title: 'Cinema Tickets',
            amount: 32.00,
            date: DateTime.now().subtract(const Duration(days: 6)),
            category: 'Entertainment',
          ),
        ]);
      }
    });
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
