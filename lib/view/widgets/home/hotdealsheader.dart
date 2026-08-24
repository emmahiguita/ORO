import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/core/constant/color.dart';

class HotDealsHeader extends StatelessWidget {
  const HotDealsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) => Opacity(
        opacity: value,
        child: Transform.translate(
          offset: Offset(0, 10 * (1 - value)),
          child: child,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('featured'.tr, style: theme.textTheme.headlineSmall),
                const SizedBox(height: 2),
                Text('featured_subtitle'.tr, style: theme.textTheme.bodySmall),
              ],
            ),
          ),
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Appcolor.accentGoldSoft,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              size: 20,
              color: Appcolor.ink,
            ),
          ),
        ],
      ),
    );
  }
}
