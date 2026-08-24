import 'package:flutter/material.dart';
import 'package:oro/controller/admin/admindashboardcontroller.dart';
import 'package:oro/view/widgets/admin/chartcontainer.dart';
import 'package:oro/view/widgets/admin/emptychart.dart';
import 'package:oro/view/widgets/admin/simplecharts.dart';

class OrderStatusChart extends StatelessWidget {
  final AdminDashboardControllerImp controller;

  const OrderStatusChart({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final ordersNumber = controller.dashboardInfo.ordersNumber;
    if (ordersNumber == null || ordersNumber.isEmpty) {
      return const EmptyChart(title: 'Estado de pedidos');
    }

    final values = ordersNumber
        .map((status) => (status.ordersNumber ?? 0).toDouble())
        .toList();
    final labels = ordersNumber
        .map((status) => controller.getStatusText(status.orderStatus ?? -1))
        .toList();

    return ChartContainer(
      title: 'Estado de pedidos',
      subtitle: 'Distribución actual de pedidos',
      chart: PremiumDonutChart(
        values: values,
        labels: labels,
      ),
    );
  }
}
