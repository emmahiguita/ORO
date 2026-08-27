import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:oro/core/design/oro_colors.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: OroColors.surfaceDarkElevated,
          highlightColor: Colors.white.withValues(alpha: .18),
          child: const CircleAvatar(
            backgroundColor: OroColors.surfaceDark,
            minRadius: 30,
          ),
        ),
        const SizedBox(height: 5),
        Shimmer.fromColors(
          baseColor: OroColors.surfaceDarkElevated,
          highlightColor: Colors.white.withValues(alpha: .18),
          child: Container(
            width: 40,
            height: 10,
            decoration: BoxDecoration(
              color: OroColors.surfaceDark,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .10),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
