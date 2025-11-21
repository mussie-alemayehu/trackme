import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/budget_controller.dart';

class SetBudgetController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();

  final BudgetController _budgetController = Get.find();

  @override
  void onInit() {
    super.onInit();
    amountController.text = _budgetController.budget.value.amount.toString();
  }

  @override
  void onClose() {
    amountController.dispose();
    super.onClose();
  }

  void saveBudget() {
    if (formKey.currentState!.validate()) {
      final amount = double.parse(amountController.text);
      _budgetController.setBudget(amount);
      Get.back();
      Get.snackbar('Success', 'Budget set successfully');
    }
  }
}
