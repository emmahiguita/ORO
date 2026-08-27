import 'package:flutter/material.dart';
import 'package:oro/core/formatters/oro_money.dart';

class FinalPriceTag extends StatelessWidget {
  final double price;

  const FinalPriceTag({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Text(
        OroMoney.format(price),
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: theme.brightness == Brightness.dark
                  ? theme.colorScheme.onPrimary
                  : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
      ),
    );
  }
}
