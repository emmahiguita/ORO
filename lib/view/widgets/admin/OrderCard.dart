import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:oro/apilink.dart';
import 'package:oro/controller/admin/orders/manageorderscontroller.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/admin/ActionButtons.dart';

class OrderCard extends StatelessWidget {
  final ManageOrdersControllerImp controller;
  final int index;
  const OrderCard({super.key, required this.controller, required this.index});

  @override
  Widget build(BuildContext context) {
    final order = controller.orders[index];
    final statusText =
        controller.getStatusText(order.orderStatus!, order.orderType!);
    final statusColor = controller.getStatusColor(order.orderStatus!);
    final theme = Theme.of(context);

    return Card(
      color: Appcolor.white,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          controller.goToOrderDetails(
              controller.orders[index].orderId.toString(), index);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order header with ID and status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.receipt_long,
                        color: theme.primaryColor,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Order #${order.orderId}",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                      border:
                          Border.all(color: statusColor.withValues(alpha: 0.3)),
                    ),
                    child: Text(
                      statusText,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Divider
              Divider(height: 1, color: Colors.grey[200]),

              const SizedBox(height: 12),

              // Order details row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // User name with avatar icon
                        Row(
                          children: [
                            Icon(
                              Icons.person_outline,
                              size: 16,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 6),
                            Text(
                              order.userName ?? 'No Name',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Email
                        if (order.userEmail != null) ...[
                          Row(
                            children: [
                              Icon(
                                Icons.email_outlined,
                                size: 16,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 6),
                              Text(
                                order.userEmail!,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                        ],

                        // Phone
                        if (order.userPhone != null) ...[
                          Row(
                            children: [
                              Icon(
                                Icons.phone_outlined,
                                size: 16,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 6),
                              Text(
                                order.userPhone!,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                        ],

                        // Order date
                        Row(
                          children: [
                            Icon(
                              Icons.access_time_outlined,
                              size: 16,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "Placed ${Jiffy.parse(order.orderDatetime!).fromNow()}",
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // User avatar
                  if (order.userPfp != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: CachedNetworkImage(
                        imageUrl: "${AppLink.pfpimage}${order.userPfp}",
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          width: 48,
                          height: 48,
                          color: Colors.grey[200],
                          child: const Icon(Icons.person_outline, size: 24),
                        ),
                        errorWidget: (context, url, error) => Container(
                          width: 48,
                          height: 48,
                          color: Colors.grey[200],
                          child: const Icon(Icons.person_outline, size: 24),
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 16),

              // Payment and delivery info in a container
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          order.orderPaymenttype == 0
                              ? Icons.credit_card_outlined
                              : Icons.money_outlined,
                          size: 18,
                          color: Colors.grey[700],
                        ),
                        const SizedBox(width: 8),
                        Text(
                          controller.getPaymentType(order.orderPaymenttype!),
                          style: theme.textTheme.bodyMedium,
                        ),
                        const Spacer(),
                        Icon(
                          order.orderType == 0
                              ? Icons.delivery_dining_outlined
                              : Icons.store_outlined,
                          size: 18,
                          color: Colors.grey[700],
                        ),
                        const SizedBox(width: 8),
                        Text(
                          controller.getOrderType(order.orderType!),
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),

                    // Address info
                    if (order.addressBymap != null ||
                        order.addressName != null) ...[
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 18,
                            color: Colors.grey[700],
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "${order.addressName ?? ''}${order.addressName != null && order.addressBymap != null ? ' - ' : ''}${order.addressBymap ?? ''}",
                              style: theme.textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Price summary with coupon info
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest
                      .withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (order.couponCode != null)
                      Row(
                        children: [
                          Icon(
                            Icons.discount_outlined,
                            size: 18,
                            color: Colors.green[700],
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "${order.couponCode!} (-${order.couponDiscount ?? 0})",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.green[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    else
                      const Icon(
                        Icons.attach_money_outlined,
                        color: Appcolor.berry,
                      ),
                    Text(
                      "Total: \$${order.orderTotalprice?.toStringAsFixed(2) ?? '0.00'}",
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Action buttons
              ActionButtons(
                controller: controller,
                order: order,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
