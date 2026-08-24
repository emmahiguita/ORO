import 'package:flutter/material.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/delivery/detailitem.dart';

class OrderSummarySection extends StatelessWidget {
  final String paymentType;
  final String totalAmount;

  const OrderSummarySection({
    super.key,
    required this.paymentType,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Appcolor.berry.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Appcolor.berry.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: DetailItem(
              label: 'Método de pago',
              value: paymentType,
              isPrice: false,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: Colors.grey[300],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: DetailItem(
              label: 'Total Amount',
              value: totalAmount,
              isPrice: true,
            ),
          ),
        ],
      ),
    );
  }
}
