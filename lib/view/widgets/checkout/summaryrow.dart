import 'package:flutter/material.dart';
import 'package:oro/core/design/oro_colors.dart';

class SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const SummaryRow({
    super.key,
    required this.label,
    required this.value,
    required this.isTotal,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.w900 : FontWeight.w600,
            fontSize: isTotal ? 15.5 : 13.5,
            letterSpacing: isTotal ? 0.3 : 0.0,
            color: isTotal
                ? (isDark ? OroColors.turquoise : OroColors.waterBlue)
                : (isDark
                    ? OroColors.crystalWhite.withValues(alpha: 0.80)
                    : OroColors.nightBlue.withValues(alpha: 0.85)),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.w900 : FontWeight.w700,
            fontSize: isTotal ? 17.5 : 14.0,
            letterSpacing: isTotal ? -0.4 : 0.0,
            color: isTotal
                ? OroColors.accentGold
                : (isDark ? OroColors.crystalWhite : OroColors.nightBlue),
          ),
        ),
      ],
    );
  }
}
