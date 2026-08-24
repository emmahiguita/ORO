import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/admin/coupon/admincouponcontroller.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/screens/admin/coupon/addnewcoupon.dart';
import 'package:oro/view/widgets/admin/buildInforow.dart';

class AdminCoupon extends StatelessWidget {
  const AdminCoupon({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdminCouponControllerImp());
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(() => const AddNewCoupon());
          },
          backgroundColor: Appcolor.berry,
          foregroundColor: Colors.white,
          icon: const Icon(Icons.add),
          label: const Text('Add Coupon'),
          tooltip: "Agregar nuevo cupón",
        ),
        body: GetBuilder<AdminCouponControllerImp>(
          builder: (controller) {
            if (controller.coupons.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.local_offer_outlined,
                      size: 80,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No Coupons Yet',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Create your first coupon to get started',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                controller.getCoupons();
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.coupons.length,
                itemBuilder: (context, index) {
                  final coupon = controller.coupons[index];
                  final isExpired =
                      controller.isExpired(coupon.couponExpirydate);
                  final isLowStock = (coupon.couponCount ?? 0) <= 5;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 2,
                    shadowColor: Colors.black.withValues(alpha: 0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: isExpired
                            ? Colors.red.withValues(alpha: 0.3)
                            : Colors.transparent,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      coupon.couponCode ?? 'N/A',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'ID: ${coupon.couponId}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Status Badge
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: isExpired
                                      ? Colors.red.withValues(alpha: 0.1)
                                      : Colors.green.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  isExpired ? 'EXPIRED' : 'ACTIVE',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        isExpired ? Colors.red : Colors.green,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Discount Badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Appcolor.berry,
                                  Appcolor.berry.withValues(alpha: 0.8),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${coupon.couponDiscount}% OFF',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Info Rows
                          BuildInfoRow(
                            icon: Icons.inventory_2_outlined,
                            label: 'Remaining Uses',
                            value: '${coupon.couponCount ?? 0}',
                            isWarning: isLowStock,
                          ),
                          const SizedBox(height: 8),
                          BuildInfoRow(
                            icon: Icons.calendar_today_outlined,
                            value: 'Expires On',
                            label:
                                controller.formatDate(coupon.couponExpirydate),
                            isWarning: isExpired,
                          ),

                          const SizedBox(height: 16),

                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    controller.goToEditCoupon(
                                        controller.coupons[index]);
                                  },
                                  icon:
                                      const Icon(Icons.edit_outlined, size: 16),
                                  label: const Text('Editar'),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Appcolor.berry,
                                    side:
                                        const BorderSide(color: Appcolor.berry),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: isExpired
                                      ? null
                                      : () async {
                                          controller.announceCouponDialog(
                                              controller, index);
                                        },
                                  icon: const Icon(
                                    Icons.notifications_active_rounded,
                                    size: 16,
                                  ),
                                  label: const Text('Announce'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Appcolor.berry,
                                    foregroundColor: Colors.white,
                                    disabledBackgroundColor: Colors.grey[300],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
