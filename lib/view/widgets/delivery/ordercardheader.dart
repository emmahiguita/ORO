import 'package:flutter/material.dart';
import 'package:oro/view/widgets/delivery/statusbadge.dart';

class OrderCardHeader extends StatelessWidget {
  final int? orderId;
  final String formattedDate;
  final String status;
  final Color statusColor;

  const OrderCardHeader({
    super.key,
    required this.orderId,
    required this.formattedDate,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order #$orderId',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              formattedDate,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        StatusBadge(
          status: status,
          color: statusColor,
        ),
      ],
    );
  }
}
