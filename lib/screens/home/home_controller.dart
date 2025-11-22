import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../controllers/budget_controller.dart';
import '../../controllers/expense_controller.dart';
import '../../routes/app_pages.dart';
import '../../models/budget.dart';

class CategoryData {
  final String name;
  final double amount;
  final Color color;
  final double percentage;

  CategoryData({
    required this.name,
    required this.amount,
    required this.color,
    required this.percentage,
  });
}

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
  // Removed goToBreakdown as it is now part of home

  // Chart & Legend Logic
  final List<Color> _colors = [
    const Color(0xFF2196F3), // Blue
    const Color(0xFFF44336), // Red
    const Color(0xFF4CAF50), // Green
    const Color(0xFFFFC107), // Amber
    const Color(0xFF9C27B0), // Purple
    const Color(0xFFFF9800), // Orange
    const Color(0xFF009688), // Teal
    const Color(0xFFE91E63), // Pink
  ];

  List<CategoryData> get categoryData {
    final expenses = _expenseController.expenses;
    if (expenses.isEmpty) return [];

    final Map<String, double> categoryTotals = {};
    double totalAmount = 0;

    for (var expense in expenses) {
      categoryTotals[expense.category] =
          (categoryTotals[expense.category] ?? 0) + expense.amount;
      totalAmount += expense.amount;
    }

    int colorIndex = 0;
    return categoryTotals.entries.map((entry) {
      final percentage = totalAmount > 0
          ? (entry.value / totalAmount) * 100
          : 0.0;
      final color = _colors[colorIndex % _colors.length];
      colorIndex++;

      return CategoryData(
        name: entry.key,
        amount: entry.value,
        color: color,
        percentage: percentage,
      );
    }).toList();
  }

  List<PieChartSectionData> get chartSections {
    return categoryData.map((data) {
      return PieChartSectionData(
        color: data.color,
        value: data.amount,
        title: '${data.percentage.toStringAsFixed(0)}%',
        radius: 50,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }
}
