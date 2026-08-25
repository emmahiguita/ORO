import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:oro/controller/home/homescreenController.dart';
import 'package:oro/controller/orders/ArchivedOrdersController.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/approutes.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/orders/detailrow.dart';
import 'package:oro/view/widgets/orders/empty.dart';
import 'package:oro/view/widgets/orders/skeletonloading.dart';

class ArchivedOrders extends StatelessWidget {
  const ArchivedOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Pedidos'),
        elevation: 0,
        centerTitle: true,
      ),
      body: GetBuilder<ArchivedOrdersControllerImp>(
        init: ArchivedOrdersControllerImp(),
        builder: (controller) => controller.statusRequest ==
                    StatusRequest.loding &&
                controller.archivedOrders.isEmpty
            ? const SkeletonLoading()
            : controller.archivedOrders.isEmpty
                ? Empty(
                    title: 'Sin Pedidos Archivados',
                    subtitle:
                        'Aún no tienes pedidos completados en tu historial.',
                    onPressedOrder: () {
                      Get.toNamed(Approutes.homescreen);
                      Get.find<HomeScreenControllerImp>().changePage(0);
                    },
                    onPressedRefresh: () {
                      controller.getArchivedOrders();
                    },
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemCount: controller.archivedOrders.length,
                    itemBuilder: (context, index) => Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header with status and time
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Chip(
                                  label: const Text(
                                    'Archived',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                  backgroundColor: Colors.grey.shade600,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                ),
                                Text(
                                  () {
                                    final dt = controller.archivedOrders[index].orderDatetime;
                                    if (dt == null || dt.isEmpty) return '';
                                    try {
                                      return Jiffy.parse(dt).fromNow();
                                    } catch (_) {
                                      return '';
                                    }
                                  }(),
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // Order details
                            DetailRow(
                              isTotal: false,
                              label: 'Delivery Price:',
                              value:
                                  '${controller.archivedOrders[index].orderPricedelivery ?? 0}',
                            ),
                            DetailRow(
                              isTotal: false,
                              label: 'Order Price:',
                              value:
                                  '${controller.archivedOrders[index].orderPrice ?? 0}',
                            ),
                            DetailRow(
                              label: 'Total Price:',
                              value:
                                  '${controller.archivedOrders[index].orderTotalprice ?? 0}',
                              isTotal: true,
                            ),
                            DetailRow(
                              isTotal: false,
                              label: 'Payment Type:',
                              value: controller.getPaymentType(controller
                                  .archivedOrders[index].orderPaymenttype ?? 0),
                            ),
                            DetailRow(
                              isTotal: false,
                              label: 'Order Type:',
                              value: controller.getOrderType(
                                  controller.archivedOrders[index].orderType ?? 0),
                            ),

                            const SizedBox(height: 12),

                            // Details button
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                onPressed: () {
                                  final orderId = controller.archivedOrders[index].orderId;
                                  if (orderId == null) return;
                                  controller.getOrderDetails(orderId.toString());
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Appcolor.amaranthpink,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'Detalle del pedido',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
