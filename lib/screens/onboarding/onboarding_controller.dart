import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../routes/app_pages.dart';

class OnboardingController extends GetxController {
  final pageController = PageController();
  final RxInt currentPage = 0.obs;
  final _storage = GetStorage();

  final List<Map<String, dynamic>> pages = [
    {
      'title': 'Track Your Expenses',
      'description':
          'Keep track of every penny you spend and manage your finances better.',
      'icon': Icons.attach_money,
    },
    {
      'title': 'Set Budgets',
      'description': 'Set monthly budgets and never overspend again.',
      'icon': Icons.savings_outlined,
    },
    {
      'title': 'Analyze Spending',
      'description':
          'Visual charts to help you understand your spending habits.',
      'icon': Icons.pie_chart_outline,
    },
  ];

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void completeOnboarding() {
    _storage.write('onboarding_complete', true);
    Get.offAllNamed(Routes.HOME);
  }

  void nextPage() {
    if (currentPage.value < pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      completeOnboarding();
    }
  }
}
