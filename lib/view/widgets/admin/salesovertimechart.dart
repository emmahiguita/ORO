import 'package:flutter/material.dart';
import 'package:oro/controller/admin/admindashboardcontroller.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/admin/chartcontainer.dart';
import 'package:oro/view/widgets/admin/emptychart.dart';
import 'package:oro/view/widgets/admin/simplecharts.dart';

class SalesOverTimeChart extends StatelessWidget {
  final AdminDashboardControllerImp controller;
  const SalesOverTimeChart({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final data = controller.dashboardInfo.salesOverWeek;
    if (data == null || data.isEmpty)
      return const EmptyChart(title: 'Ventas en el tiempo');
    return ChartContainer(
      title: 'Ventas en el tiempo',
      subtitle: 'Rendimiento semanal',
      chart: PremiumLineChart(
        values:
            data.map((e) => double.tryParse(e.totalSales ?? '0') ?? 0).toList(),
        labels: data.map((e) => e.dayName ?? '').toList(),
        color: Appcolor.accentGold,
      ),
    );
  }
}
