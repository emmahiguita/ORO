import 'package:flutter/material.dart';
import 'package:oro/core/constant/color.dart';

class OrderRequestPriceSection extends StatelessWidget {
  final dynamic order;

  const OrderRequestPriceSection({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Appcolor.berry.withValues(alpha: 0.05),
            Appcolor.berry.withValues(alpha: 0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Appcolor.berry.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total Amount',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          Text(
            '\$${order.orderTotalprice ?? 0}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Appcolor.berry,
            ),
          ),
        ],
      ),
    );
  }
}
