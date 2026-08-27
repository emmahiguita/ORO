import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oro/controller/delivery/acceptedorderscontroller.dart';
import 'package:oro/view/widgets/delivery/customerinfosection.dart';
import 'package:oro/view/widgets/delivery/orderactionbuttons.dart';
import 'package:oro/view/widgets/delivery/ordercardheader.dart';
import 'package:oro/view/widgets/delivery/ordersummarysection.dart';

class OrderCard extends StatelessWidget {
  final AcceptedOrdersControllerImp controller;
  final int index;
  final String status;
  final Color statusColor;

  const OrderCard({
    super.key,
    required this.controller,
    required this.index,
    this.status = 'In Progress',
    this.statusColor = Colors.orange,
  });

  @override
  Widget build(BuildContext context) {
    final order = controller.acceptedOrders[index];
    final formattedDate = order.orderDatetime != null
        ? () {
            try {
              final dt = DateTime.tryParse(order.orderDatetime!);
              return dt != null
                  ? DateFormat('MMM dd, yyyy - hh:mm a').format(dt)
                  : (order.orderDatetime ?? 'N/A');
            } catch (_) {
              return order.orderDatetime ?? 'N/A';
            }
          }()
        : 'N/A';

    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrderCardHeader(
              orderId: order.orderId,
              formattedDate: formattedDate,
              status: status,
              statusColor: statusColor,
            ),
            const SizedBox(height: 20),
            CustomerInfoSection(order: order),
            const SizedBox(height: 16),
            OrderSummarySection(
              paymentType: controller.getPaymentType(order.orderPaymenttype ?? 0),
              totalAmount:
                  '\$${order.orderTotalprice?.toStringAsFixed(2) ?? '0.00'}',
            ),
            const SizedBox(height: 20),
            OrderActionButtons(
              controller: controller,
              order: order,
              index: index,
            ),
          ],
        ),
      ),
    );
  }
}
