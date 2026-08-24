import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:oro/controller/admin/admindashboardcontroller.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/view/widgets/admin/statcard.dart';

class StatsRow extends StatelessWidget {
  const StatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminDashboardControllerImp>(
      builder: (controller) => MasonryGridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        itemCount: 4,
        itemBuilder: (context, index) {
          if (controller.statusRequest == StatusRequest.loding) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Card(
                elevation: 2,
                child: Container(
                  height: 100,
                ),
              ),
            );
          } else {
            final stats = [
              StatCard(
                title: 'Total Sales',
                value: '\$${controller.dashboardInfo.sales}',
                icon: Iconsax.wallet,
                gradientColors: [Colors.blue.shade400, Colors.blue.shade600],
              ),
              StatCard(
                title: 'Pedidos',
                value: '${controller.dashboardInfo.order}',
                icon: Iconsax.shopping_cart,
                gradientColors: [Colors.green.shade400, Colors.green.shade600],
              ),
              StatCard(
                title: 'Products',
                value: '${controller.dashboardInfo.items}',
                icon: Iconsax.shop,
                gradientColors: [
                  Colors.orange.shade400,
                  Colors.orange.shade600
                ],
              ),
              StatCard(
                title: 'Customers',
                value: '${controller.dashboardInfo.customer}',
                icon: Iconsax.profile_2user,
                gradientColors: [
                  Colors.purple.shade400,
                  Colors.purple.shade600
                ],
              ),
            ];
            return stats[index];
          }
        },
      ),
    );
  }
}
