import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:oro/core/design/oro_colors.dart';

/// Reusable Water Liquid Glass Surface Widget
class LiquidGlassSurface extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double blurSigma;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Border? border;
  final List<BoxShadow>? boxShadow;
  final Gradient? gradient;

  const LiquidGlassSurface({
    super.key,
    required this.child,
    this.borderRadius = 22,
    this.blurSigma = 14,
    this.padding,
    this.margin,
    this.border,
    this.boxShadow,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final defaultBorder = border ??
        Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.22)
              : OroColors.waterBlue.withValues(alpha: 0.25),
          width: 1,
        );

    final defaultShadow = boxShadow ??
        [
          BoxShadow(
            color: (isDark ? OroColors.turquoise : OroColors.waterBlue)
                .withValues(alpha: 0.12),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.08),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ];

    final defaultGradient = gradient ??
        (isDark
            ? OroColors.liquidGlassGradient
            : OroColors.liquidGlassLightGradient);

    Widget content = Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: defaultShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              gradient: defaultGradient,
              borderRadius: BorderRadius.circular(borderRadius),
              border: defaultBorder,
            ),
            child: child,
          ),
        ),
      ),
    );

    return RepaintBoundary(child: content);
  }
}
