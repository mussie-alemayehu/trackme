import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'category_breakdown_controller.dart';

class CategoryBreakdownView extends GetView<CategoryBreakdownController> {
  const CategoryBreakdownView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Category Breakdown')),
      body: Obx(() {
        if (controller.expenses.isEmpty) {
          return const Center(child: Text('No data'));
        }

        final sections = controller.getSections();
        final totals = controller.getCategoryTotals();

        return Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: sections,
                  centerSpaceRadius: 40,
                  sectionsSpace: 2,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: totals.length,
                itemBuilder: (context, index) {
                  final entry = totals.entries.elementAt(index);
                  return ListTile(
                    title: Text(entry.key),
                    trailing: Text('\$${entry.value.toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
