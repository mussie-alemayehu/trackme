import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'expense_list_controller.dart';

class ExpenseListView extends GetView<ExpenseListController> {
  const ExpenseListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expenses')),
      body: Obx(() {
        if (controller.expenses.isEmpty) {
          return const Center(child: Text('No expenses yet'));
        }
        return ListView.builder(
          itemCount: controller.expenses.length,
          itemBuilder: (context, index) {
            final expense = controller.expenses[index];
            return ListTile(
              title: Text(expense.title),
              subtitle: Text(DateFormat.yMMMd().format(expense.date)),
              trailing: Text('\$${expense.amount.toStringAsFixed(2)}'),
              onTap: () => controller.editExpense(expense),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.goToAddExpense,
        child: const Icon(Icons.add),
      ),
    );
  }
}
