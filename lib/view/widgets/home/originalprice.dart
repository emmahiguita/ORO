import 'package:flutter/material.dart';

class OriginalPrice extends StatelessWidget {
  final String price;

  const OriginalPrice({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Text(
      '\$$price',
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            decoration: TextDecoration.lineThrough,
            decorationThickness: 1.4,
            color:
                Theme.of(context).colorScheme.onSurface.withValues(alpha: .45),
          ),
    );
  }
}
