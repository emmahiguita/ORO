import 'package:flutter/material.dart';
import 'package:oro/controller/admin/admindashboardcontroller.dart';
import 'package:oro/view/widgets/admin/chartcontainer.dart';
import 'package:oro/view/widgets/admin/emptychart.dart';
import 'package:oro/view/widgets/admin/simplecharts.dart';

class TopCategoriesChart extends StatelessWidget {
  final AdminDashboardControllerImp controller;

  const TopCategoriesChart({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final topCategories = controller.dashboardInfo.topCategories;
    if (topCategories == null || topCategories.isEmpty) {
      return const EmptyChart(title: 'Categorías más vendidas');
    }

    final values =
        topCategories.map((cat) => (cat.totalSelling ?? 0).toDouble()).toList();
    final labels = topCategories.map((cat) => cat.categoryName ?? '').toList();

    return ChartContainer(
      title: 'Categorías más vendidas',
      subtitle: 'Rendimiento por categoría de producto',
      chart: PremiumDonutChart(
        values: values,
        labels: labels,
        holeRadius: 0.45,
      ),
    );
  }
}
