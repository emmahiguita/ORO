import 'package:flutter/material.dart';

class OriginalPriceTag extends StatelessWidget {
  final double price;

  const OriginalPriceTag({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey[600],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Text(
        "\$${price.toStringAsFixed(2)}",
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white,
              decoration: TextDecoration.lineThrough,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}
