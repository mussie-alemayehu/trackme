// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import '../screens/splash/splash_binding.dart';
import '../screens/splash/splash_view.dart';
import '../screens/onboarding/onboarding_binding.dart';
import '../screens/onboarding/onboarding_view.dart';
import '../screens/home/home_binding.dart';
import '../screens/home/home_view.dart';
import '../screens/set_budget/set_budget_binding.dart';
import '../screens/set_budget/set_budget_view.dart';
import '../screens/expense_list/expense_list_binding.dart';
import '../screens/expense_list/expense_list_view.dart';
import '../screens/add_edit_expense/add_edit_expense_binding.dart';
import '../screens/add_edit_expense/add_edit_expense_view.dart';

abstract class Routes {
  Routes._();
  static const SPLASH = '/splash';
  static const ONBOARDING = '/onboarding';
  static const HOME = '/home';
  static const SET_BUDGET = '/set-budget';
  static const EXPENSE_LIST = '/expense-list';
  static const ADD_EXPENSE = '/add-expense';
  static const EDIT_EXPENSE = '/edit-expense';
  static const CATEGORY_BREAKDOWN = '/category-breakdown';
}

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.SET_BUDGET,
      page: () => const SetBudgetView(),
      binding: SetBudgetBinding(),
    ),
    GetPage(
      name: Routes.EXPENSE_LIST,
      page: () => const ExpenseListView(),
      binding: ExpenseListBinding(),
    ),
    GetPage(
      name: Routes.ADD_EXPENSE,
      page: () => const AddEditExpenseView(),
      binding: AddEditExpenseBinding(),
    ),
    GetPage(
      name: Routes.EDIT_EXPENSE,
      page: () => const AddEditExpenseView(),
      binding: AddEditExpenseBinding(),
    ),
  ];
}
