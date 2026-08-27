import 'package:flutter/material.dart';

class ProductDescription extends StatelessWidget {
  final String description;

  const ProductDescription({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color:
                Theme.of(context).colorScheme.onSurface.withValues(alpha: .7),
            height: 1.6,
            fontSize: 16,
          ),
    );
  }
}
