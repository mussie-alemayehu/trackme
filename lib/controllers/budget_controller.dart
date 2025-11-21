import 'package:get/get.dart';
import '../models/budget.dart';

class BudgetController extends GetxController {
  final Rx<Budget> budget = Budget(amount: 0.0).obs;

  void setBudget(double amount) {
    budget.update((val) {
      val?.amount = amount;
    });
  }

  double get totalAmount => budget.value.amount;
}
