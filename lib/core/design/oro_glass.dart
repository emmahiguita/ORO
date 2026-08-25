import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:oro/core/design/oro_colors.dart';

/// Performance-optimized Glass Surface for floating controls, bottom bar and modal sheets.
/// Uses bounded blur (sigma 12) strictly within a clipped region.
class OroGlassSurface extends StatelessWidget {
  final Widget child;
  final double blurSigma;
  final BorderRadius borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;

  const OroGlassSurface({
    super.key,
    required this.child,
    this.blurSigma = 12.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(28)),
    this.backgroundColor,
    this.borderColor,
    this.padding,
    this.margin,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = backgroundColor ??
        (isDark
            ? OroColors.surfaceDark.withValues(alpha: 0.85)
            : OroColors.surface.withValues(alpha: 0.88));
    final border = borderColor ??
        (isDark
            ? OroColors.borderDark.withValues(alpha: 0.5)
            : OroColors.borderLight.withValues(alpha: 0.7));

    Widget content = Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: borderRadius,
        border: Border.all(color: border, width: 1),
      ),
      child: child,
    );

    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: content,
        ),
      ),
    );
  }
}
