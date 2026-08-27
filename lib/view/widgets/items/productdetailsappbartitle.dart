import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:oro/core/design/oro_colors.dart';

class ProductDetailsAppBarTitle extends StatelessWidget {
  const ProductDetailsAppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
            color: OroColors.nightBlue.withValues(alpha: 0.70),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.22),
            ),
          ),
          child: const Text(
            'Detalle del producto',
            style: TextStyle(
              color: OroColors.crystalWhite,
              fontWeight: FontWeight.w800,
              fontSize: 14,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }
}
