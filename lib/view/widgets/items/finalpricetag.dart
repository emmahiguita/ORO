import 'package:flutter/material.dart';
import 'package:oro/core/constant/color.dart';

class FinalPriceTag extends StatelessWidget {
  final double price;

  const FinalPriceTag({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Appcolor.amaranthpink, Colors.pink[400]!],
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Appcolor.amaranthpink.withValues(alpha: 0.4),
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Text(
        "\$${price.toStringAsFixed(2)}",
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
      ),
    );
  }
}
