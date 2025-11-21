// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const ONBOARDING = _Paths.ONBOARDING;
  static const HOME = _Paths.HOME;
  static const SET_BUDGET = _Paths.SET_BUDGET;
  static const EXPENSE_LIST = _Paths.EXPENSE_LIST;
  static const ADD_EXPENSE = _Paths.ADD_EXPENSE;
  static const EDIT_EXPENSE = _Paths.EDIT_EXPENSE;
  static const CATEGORY_BREAKDOWN = _Paths.CATEGORY_BREAKDOWN;
}

abstract class _Paths {
  _Paths._();
  static const SPLASH = '/splash';
  static const ONBOARDING = '/onboarding';
  static const HOME = '/home';
  static const SET_BUDGET = '/set-budget';
  static const EXPENSE_LIST = '/expense-list';
  static const ADD_EXPENSE = '/add-expense';
  static const EDIT_EXPENSE = '/edit-expense';
  static const CATEGORY_BREAKDOWN = '/category-breakdown';
}
