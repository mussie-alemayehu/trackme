import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/expense.dart';
import '../../controllers/expense_controller.dart';

class AddEditExpenseController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final categoryController = TextEditingController();

  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final RxBool isEditing = false.obs;
  String? expenseId;

  final ExpenseController _expenseController = Get.find();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is Expense) {
      final Expense expense = Get.arguments;
      isEditing.value = true;
      expenseId = expense.id;
      titleController.text = expense.title;
      amountController.text = expense.amount.toString();
      categoryController.text = expense.category;
      selectedDate.value = expense.date;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    amountController.dispose();
    categoryController.dispose();
    super.onClose();
  }

  void saveExpense() {
    if (formKey.currentState!.validate()) {
      final title = titleController.text;
      final amount = double.parse(amountController.text);
      final category = categoryController.text;
      final date = selectedDate.value;

      if (isEditing.value) {
        // Update existing
        final updatedExpense = Expense(
          id: expenseId!,
          title: title,
          amount: amount,
          date: date,
          category: category,
        );
        _expenseController.updateExpense(updatedExpense);
      } else {
        // Add new
        final newExpense = Expense(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: title,
          amount: amount,
          date: date,
          category: category,
        );
        _expenseController.addExpense(newExpense);
      }

      Get.back();
    }
  }
}
