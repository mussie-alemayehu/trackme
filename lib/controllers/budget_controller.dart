import 'package:get/get.dart';
import '../models/budget.dart';
import '../services/database_service.dart';

class BudgetController extends GetxController {
  final Rx<Budget> budget = Budget(amount: 0.0).obs;
  final DatabaseService _databaseService = DatabaseService();

  @override
  void onInit() {
    super.onInit();
    _loadBudget();
  }

  Future<void> _loadBudget() async {
    final amount = await _databaseService.getBudget();
    budget.update((val) {
      val?.amount = amount;
    });
  }

  void setBudget(double amount) {
    budget.update((val) {
      val?.amount = amount;
    });
    _databaseService.updateBudget(amount);
  }

  double get totalAmount => budget.value.amount;
}
