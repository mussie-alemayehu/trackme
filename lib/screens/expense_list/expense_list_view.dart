import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'expense_list_controller.dart';
import '../../theme/app_colors.dart';

class ExpenseListView extends GetView<ExpenseListController> {
  const ExpenseListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expenses')),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).cardColor,
            child: Column(
              children: [
                // Search Bar
                TextField(
                  onChanged: (val) => controller.searchQuery.value = val,
                  decoration: InputDecoration(
                    hintText: 'Search name, amount, category...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: Obx(
                      () => controller.searchQuery.value.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () =>
                                  controller.searchQuery.value = '',
                            )
                          : const SizedBox.shrink(),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
                const SizedBox(height: 12),
                // Filters Row
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      // Date Filter
                      Obx(() {
                        final hasDate = controller.dateRange.value != null;
                        return FilterChip(
                          label: Text(
                            hasDate
                                ? '${DateFormat.MMMd().format(controller.dateRange.value!.start)} - ${DateFormat.MMMd().format(controller.dateRange.value!.end)}'
                                : 'Date Range',
                          ),
                          selected: hasDate,
                          onSelected: (selected) async {
                            if (selected) {
                              final picked = await showDateRangePicker(
                                context: context,
                                firstDate: DateTime(2020),
                                lastDate: DateTime.now(),
                                initialDateRange: controller.dateRange.value,
                              );
                              if (picked != null) {
                                controller.dateRange.value = picked;
                              }
                            } else {
                              controller.dateRange.value = null;
                            }
                          },
                          avatar: hasDate
                              ? const Icon(Icons.close, size: 18)
                              : const Icon(Icons.calendar_today, size: 18),
                          showCheckmark: false,
                        );
                      }),
                      const SizedBox(width: 8),
                      // Category Filter
                      Obx(() {
                        final selected = controller.selectedCategory.value;
                        return PopupMenuButton<String>(
                          initialValue: selected,
                          onSelected: (val) =>
                              controller.selectedCategory.value = val,
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: '',
                              child: Text('All Categories'),
                            ),
                            ...controller.categories.map(
                              (cat) =>
                                  PopupMenuItem(value: cat, child: Text(cat)),
                            ),
                          ],
                          child: Chip(
                            label: Text(
                              selected.isEmpty ? 'Category' : selected,
                            ),
                            avatar: selected.isNotEmpty
                                ? const Icon(Icons.close, size: 18)
                                : const Icon(Icons.category, size: 18),
                            deleteIcon: const Icon(Icons.close, size: 18),
                            onDeleted: selected.isNotEmpty
                                ? () => controller.selectedCategory.value = ''
                                : null,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // List
          Expanded(
            child: Obx(() {
              final expenses = controller.filteredExpenses;
              if (expenses.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        'No expenses found',
                        style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      ),
                    ],
                  ),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.all(
                  16,
                ).copyWith(bottom: Get.mediaQuery.viewPadding.bottom + 16),
                itemCount: expenses.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final expense = expenses[index];

                  return Card(
                    elevation: 0,
                    color: Theme.of(context).cardTheme.color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: Colors.grey.withValues(alpha: 0.1),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: CircleAvatar(
                        backgroundColor: AppColors.primary.withValues(
                          alpha: 0.1,
                        ),
                        child: const Icon(
                          Icons.attach_money,
                          color: AppColors.primary,
                        ),
                      ),
                      title: Text(
                        expense.title,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            expense.category,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            DateFormat.yMMMd().format(expense.date),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                      trailing: Text(
                        '\$${expense.amount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.primary,
                        ),
                      ),
                      onTap: () => controller.editExpense(expense),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.goToAddExpense,
        child: const Icon(Icons.add),
      ),
    );
  }
}
