import 'package:flutter/material.dart';
import 'package:oro/apilink.dart';
import 'package:oro/controller/admin/admindashboardcontroller.dart';
import 'package:oro/core/class/graph.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/admin/chartcontainer.dart';
import 'package:oro/view/widgets/admin/emptychart.dart';
import 'package:oro/view/widgets/admin/simplecharts.dart';
import 'package:oro/view/widgets/admin/workeravatar.dart';

class DeliveryWorkersSection extends StatelessWidget {
  final AdminDashboardControllerImp controller;
  const DeliveryWorkersSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final workers = controller.dashboardInfo.deliveryWorkers;
    if (workers == null || workers.isEmpty)
      return const EmptyChart(title: 'Rendimiento de repartidores');
    final workerData = workers
        .map((worker) => DeliveryWorkerData(
              worker.userName ?? '',
              worker.numberOfOrders ?? 0,
              AppLink.pfpimage + (worker.userPfp ?? ''),
            ))
        .toList();
    return ChartContainer(
      title: 'Rendimiento de repartidores',
      subtitle: 'Pedidos completados por cada repartidor',
      chart: Column(children: [
        PremiumBarChart(
          values: workerData.map((e) => e.numberOfOrders.toDouble()).toList(),
          labels: workerData.map((e) => e.userName).toList(),
          color: Appcolor.navy,
        ),
        const SizedBox(height: 16),
        WorkerAvatars(workerData: workerData),
      ]),
    );
  }
}

class WorkerAvatars extends StatelessWidget {
  final List<DeliveryWorkerData> workerData;
  const WorkerAvatars({super.key, required this.workerData});
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: workerData
                  .map((worker) => Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: WorkerAvatar(worker: worker),
                      ))
                  .toList()),
        ),
      ),
    );
  }
}
