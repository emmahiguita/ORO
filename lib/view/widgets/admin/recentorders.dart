import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:oro/apilink.dart';
import 'package:oro/controller/admin/admindashboardcontroller.dart';
import 'package:oro/controller/admin/adminhomecontroller.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/core/constant/color.dart';

class RecentOrders extends StatelessWidget {
  const RecentOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminDashboardControllerImp>(
      builder: (controller) => Card(
        color: Appcolor.white,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              if (controller.statusRequest == StatusRequest.loding)
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                )
              else
                ...controller.dashboardInfo.orders!.map((order) => Column(
                      children: [
                        ListTile(
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: AppLink.pfpimage + order.userPfp!,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Iconsax.shop),
                              ),
                            ),
                          ),
                          title: Text("#${order.orderId}"),
                          subtitle: Text(order.userName ?? ''),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${order.orderTotalprice.toString()}\$",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Appcolor.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: controller
                                      .getStatusColor(order.orderStatus!)
                                      .withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  controller.getStatusText(order.orderStatus!),
                                  style: TextStyle(
                                    color: controller
                                        .getStatusColor(order.orderStatus!),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(height: 1),
                      ],
                    )),
              TextButton(
                onPressed: () {
                  Get.find<AdminHomeControllerImp>().changePage(3);
                },
                child: const Text('View All Orders'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
