import 'package:flutter/material.dart';
import 'package:oro/core/constant/color.dart';

class PaymentTypeBadge extends StatelessWidget {
  final String paymentType;

  const PaymentTypeBadge({super.key, required this.paymentType});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Appcolor.berry.withValues(alpha: 0.1),
            Appcolor.berry.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Appcolor.berry.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Text(
        paymentType,
        style: const TextStyle(
          color: Appcolor.berry,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
