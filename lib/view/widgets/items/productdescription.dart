import 'package:flutter/material.dart';
import 'package:oro/core/design/oro_colors.dart';

class ProductDescription extends StatelessWidget {
  final String description;

  const ProductDescription({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: TextStyle(
        color: OroColors.crystalWhite.withValues(alpha: 0.85),
        height: 1.55,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
