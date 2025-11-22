import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/expense.dart';
import '../../routes/app_pages.dart';
import '../../controllers/expense_controller.dart';

class ExpenseListController extends GetxController {
  final ExpenseController _expenseController = Get.find();

  // Filter States
  final RxString searchQuery = ''.obs;
  final Rx<DateTimeRange?> dateRange = Rx<DateTimeRange?>(null);
  final RxString selectedCategory = ''.obs;

  // Derived List
  List<Expense> get filteredExpenses {
    return _expenseController.expenses.where((expense) {
      // 1. Search Query
      if (searchQuery.value.isNotEmpty) {
        final query = searchQuery.value.toLowerCase();
        final matchesTitle = expense.title.toLowerCase().contains(query);
        final matchesCategory = expense.category.toLowerCase().contains(query);
        final matchesAmount = expense.amount.toString().contains(query);
        if (!matchesTitle && !matchesCategory && !matchesAmount) return false;
      }

      // 2. Date Range
      if (dateRange.value != null) {
        if (expense.date.isBefore(dateRange.value!.start) ||
            expense.date.isAfter(
              dateRange.value!.end.add(const Duration(days: 1)),
            )) {
          return false;
        }
      }

      // 3. Category Filter
      if (selectedCategory.value.isNotEmpty) {
        if (expense.category != selectedCategory.value) return false;
      }

      return true;
    }).toList();
  }

  // Available Categories for Filter
  List<String> get categories {
    return _expenseController.expenses.map((e) => e.category).toSet().toList();
  }

  void clearFilters() {
    searchQuery.value = '';
    dateRange.value = null;
    selectedCategory.value = '';
  }

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
