import 'package:flutter/material.dart';
import 'package:oro/core/design/oro_colors.dart';

class SpecRow extends StatelessWidget {
  final String label;
  final String value;

  const SpecRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isDark ? OroColors.turquoise : OroColors.waterBlue,
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 16),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 13.5,
                color: isDark ? OroColors.crystalWhite : OroColors.nightBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
