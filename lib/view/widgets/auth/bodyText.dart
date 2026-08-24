import 'package:flutter/material.dart';

class AUTHBText extends StatelessWidget {
  final String text;
  const AUTHBText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color:
                Theme.of(context).colorScheme.onSurface.withValues(alpha: .62),
          ),
      textAlign: TextAlign.center,
    );
  }
}
