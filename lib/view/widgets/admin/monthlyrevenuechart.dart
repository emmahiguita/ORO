import 'package:flutter/material.dart';
import 'package:oro/controller/admin/admindashboardcontroller.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/admin/chartcontainer.dart';
import 'package:oro/view/widgets/admin/emptychart.dart';
import 'package:oro/view/widgets/admin/simplecharts.dart';

class MonthlyRevenueChart extends StatelessWidget {
  final AdminDashboardControllerImp controller;
  const MonthlyRevenueChart({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final data = controller.dashboardInfo.salesOverMonth;
    if (data == null || data.isEmpty) {
      return const EmptyChart(title: 'Ingresos mensuales');
    }
    return ChartContainer(
      title: 'Ingresos mensuales',
      subtitle: 'Tendencia de ingresos por mes',
      chart: PremiumBarChart(
        values:
            data.map((e) => double.tryParse(e.totalSales ?? '0') ?? 0).toList(),
        labels: data.map((e) => e.monthShort ?? '').toList(),
        color: Appcolor.forest,
      ),
    );
  }
}
