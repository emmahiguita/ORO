import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:oro/core/design/oro_colors.dart';

class DiscountBadge extends StatelessWidget {
  final int discount;
  final String? label;

  const DiscountBadge({
    super.key,
    required this.discount,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    if (discount <= 0 && label == null) return const SizedBox.shrink();

    final displayText = label ?? '-$discount%';

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3.5),
          decoration: BoxDecoration(
            gradient: OroColors.emeraldGradient,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.30),
              width: 0.8,
            ),
            boxShadow: [
              BoxShadow(
                color: OroColors.emerald.withValues(alpha: 0.35),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            displayText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 9.5,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}
