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
import '../screens/category_breakdown/category_breakdown_binding.dart';
import '../screens/category_breakdown/category_breakdown_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SET_BUDGET,
      page: () => const SetBudgetView(),
      binding: SetBudgetBinding(),
    ),
    GetPage(
      name: _Paths.EXPENSE_LIST,
      page: () => const ExpenseListView(),
      binding: ExpenseListBinding(),
    ),
    GetPage(
      name: _Paths.ADD_EXPENSE,
      page: () => const AddEditExpenseView(),
      binding: AddEditExpenseBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_EXPENSE,
      page: () => const AddEditExpenseView(),
      binding: AddEditExpenseBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY_BREAKDOWN,
      page: () => const CategoryBreakdownView(),
      binding: CategoryBreakdownBinding(),
    ),
  ];
}
