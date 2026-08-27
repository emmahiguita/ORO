import 'package:flutter/material.dart';
import 'package:oro/controller/admin/orders/AdminOrderDetailsController.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/functions/format_relative_date.dart';

class OrderSummaryCard extends StatelessWidget {
  final AdminOrderDetailsControllerImp controller;
  const OrderSummaryCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final status = controller.adminDetailsModel.orderStatus ?? 0;
    final type = controller.adminDetailsModel.orderType ?? 0;
    final paymentType = controller.adminDetailsModel.orderPaymenttype ?? 0;
    final dtStr = controller.adminDetailsModel.orderDatetime;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Appcolor.berry.withValues(alpha: 0.05),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Order Status', style: TextStyle(color: Colors.grey[600])),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Appcolor.berry.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Appcolor.berry),
                  ),
                  child: Text(
                    controller.getStatusText(status, type),
                    style: const TextStyle(
                      color: Appcolor.berry,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Order Date', style: TextStyle(color: Colors.grey[600])),
                Text(
                    formatDisplayDate(dtStr,
                        pattern: 'dd MMM yyyy, hh:mm a', fallback: 'N/A'),
                    style: TextStyle(color: Colors.grey[800])),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Método de pago',
                    style: TextStyle(color: Colors.grey[600])),
                Text(
                    controller.getPaymentType(paymentType),
                    style: TextStyle(color: Colors.grey[800])),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Delivery Type',
                    style: TextStyle(color: Colors.grey[600])),
                Text(
                    controller.adminDetailsModel.orderType == 0
                        ? "Delivery"
                        : "Pickup",
                    style: TextStyle(color: Colors.grey[800])),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
