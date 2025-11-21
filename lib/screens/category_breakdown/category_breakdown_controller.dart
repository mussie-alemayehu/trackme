import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../controllers/expense_controller.dart';

class CategoryBreakdownController extends GetxController {
  final ExpenseController _expenseController = Get.find();

  List<PieChartSectionData> getSections() {
    final expenses = _expenseController.expenses;
    if (expenses.isEmpty) return [];

    final Map<String, double> categoryTotals = {};
    double totalAmount = 0;

    for (var expense in expenses) {
      categoryTotals[expense.category] =
          (categoryTotals[expense.category] ?? 0) + expense.amount;
      totalAmount += expense.amount;
    }

    final List<Color> colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.yellow,
      Colors.purple,
      Colors.orange,
    ];

    int colorIndex = 0;
    return categoryTotals.entries.map((entry) {
      final percentage = (entry.value / totalAmount) * 100;
      final color = colors[colorIndex % colors.length];
      colorIndex++;

      return PieChartSectionData(
        color: color,
        value: entry.value,
        title: '${percentage.toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  Map<String, double> getCategoryTotals() {
    final expenses = _expenseController.expenses;
    final Map<String, double> categoryTotals = {};

    for (var expense in expenses) {
      categoryTotals[expense.category] =
          (categoryTotals[expense.category] ?? 0) + expense.amount;
    }
    return categoryTotals;
  }

  // Expose expenses for Obx in view
  get expenses => _expenseController.expenses;
}
