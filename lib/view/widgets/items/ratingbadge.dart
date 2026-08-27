import 'package:flutter/material.dart';

class RatingBadge extends StatelessWidget {
  final String rating;

  const RatingBadge({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: theme.colorScheme.secondary.withValues(alpha: .38)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star_rounded,
              color: theme.colorScheme.secondary, size: 16),
          const SizedBox(width: 4),
          Text(
            (double.tryParse(rating) ?? 0.0).toStringAsFixed(1),
            style: TextStyle(
              color: theme.colorScheme.onSecondaryContainer,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
