import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:oro/core/design/oro_colors.dart';

class LoadingItemState extends StatelessWidget {
  const LoadingItemState({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: OroColors.surfaceDarkElevated,
      highlightColor: Colors.white.withValues(alpha: .16),
      child: Container(
        width: double.infinity,
        height: 340,
        decoration: BoxDecoration(
          color: OroColors.surfaceDark,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .14),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
      ),
    );
  }
}
