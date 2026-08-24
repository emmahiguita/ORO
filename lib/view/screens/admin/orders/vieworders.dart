import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/admin/orders/manageorderscontroller.dart';
import 'package:oro/view/widgets/admin/AdminFilterChip.dart';
import 'package:oro/view/widgets/admin/OrderCard.dart';
import 'package:oro/view/widgets/admin/SortButton.dart';

class ViewOrders extends StatelessWidget {
  const ViewOrders({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ManageOrdersControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders Management'),
        centerTitle: true,
      ),
      body: GetBuilder<ManageOrdersControllerImp>(
        builder: (controller) => Column(
          children: [
            // Filter chips section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    AdminFilterChip(
                      label: "All",
                      icon: Icons.list_alt,
                      selected: controller.currentFilter == null,
                      onSelected: (bool selected) {
                        if (selected) controller.setFilter(null);
                      },
                    ),
                    const SizedBox(width: 8),
                    AdminFilterChip(
                      label: "Pendiente",
                      icon: Icons.pending_actions,
                      selected: controller.currentFilter == 0,
                      onSelected: (bool selected) {
                        if (selected) controller.setFilter(0);
                      },
                    ),
                    const SizedBox(width: 8),
                    AdminFilterChip(
                      label: "Preparing",
                      icon: Icons.restaurant,
                      selected: controller.currentFilter == 1,
                      onSelected: (bool selected) {
                        if (selected) controller.setFilter(1);
                      },
                    ),
                    const SizedBox(width: 8),
                    AdminFilterChip(
                      label: "Ready",
                      icon: Icons.assignment_turned_in,
                      selected: controller.currentFilter == 4,
                      onSelected: (bool selected) {
                        if (selected) controller.setFilter(4);
                      },
                    ),
                    const SizedBox(width: 8),
                    AdminFilterChip(
                      label: "Completed",
                      icon: Icons.done_all,
                      selected: controller.currentFilter == 5,
                      onSelected: (bool selected) {
                        if (selected) controller.setFilter(5);
                      },
                    ),
                    const SizedBox(width: 8),
                    AdminFilterChip(
                      label: "Cancelado",
                      icon: Icons.cancel,
                      selected: controller.currentFilter == -1,
                      onSelected: (bool selected) {
                        if (selected) controller.setFilter(-1);
                      },
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Sort by Status
                  SortButton(
                    icon: Icons.sort_by_alpha,
                    label: 'Status',
                    onPressed: () => controller.sortByStatus(),
                    color: const Color(0xffa43068),
                    isActive: controller.activeSortType == 0,
                  ),

                  const VerticalDivider(
                    thickness: 1,
                    indent: 8,
                    endIndent: 8,
                    color: Colors.grey,
                  ),

                  // Sort by Date - Oldest First
                  SortButton(
                    icon: Icons.arrow_upward,
                    label: 'Oldest',
                    onPressed: () => controller.sortByDate(),
                    color: const Color(0xffa43068),
                    isActive: controller.activeSortType == 1,
                  ),

                  const SizedBox(width: 8),

                  // Sort by Date - Newest First
                  SortButton(
                    icon: Icons.arrow_downward,
                    label: 'Newest',
                    onPressed: () => controller.sortByDate(ascending: false),
                    color: const Color(0xffa43068),
                    isActive: controller.activeSortType == 2,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Orders list
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await controller.getOrders();
                },
                child: ListView.separated(
                  itemCount: controller.orders.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) =>
                      OrderCard(controller: controller, index: index),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
