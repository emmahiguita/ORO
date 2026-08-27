import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/core/design/oro_motion.dart';

class GlassIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String tooltip;
  final double size;
  final double iconSize;
  final Color? iconColor;
  final Gradient? backgroundGradient;

  const GlassIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.tooltip,
    this.size = 48,
    this.iconSize = 20,
    this.iconColor,
    this.backgroundGradient,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Semantics(
      button: true,
      label: tooltip,
      child: Tooltip(
        message: tooltip,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed == null
                ? null
                : () async {
                    await OroMotion.selectionHaptic();
                    onPressed!();
                  },
            borderRadius: BorderRadius.circular(size / 2),
            child: SizedBox(
              width: size,
              height: size,
              child: Center(
                child: ClipOval(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      width: size - 8,
                      height: size - 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: backgroundGradient ??
                            (isDark
                                ? LinearGradient(
                                    colors: [
                                      Colors.black.withValues(alpha: 0.50),
                                      OroColors.nightBlue.withValues(alpha: 0.70),
                                    ],
                                  )
                                : LinearGradient(
                                    colors: [
                                      Colors.white.withValues(alpha: 0.90),
                                      const Color(0xFFEAF4FA)
                                          .withValues(alpha: 0.80),
                                    ],
                                  )),
                        border: Border.all(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.20)
                              : OroColors.waterBlue.withValues(alpha: 0.25),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: (isDark
                                    ? OroColors.turquoise
                                    : OroColors.waterBlue)
                                .withValues(alpha: 0.12),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          icon,
                          size: iconSize,
                          color: iconColor ??
                              (isDark
                                  ? OroColors.crystalWhite
                                  : OroColors.nightBlue),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
