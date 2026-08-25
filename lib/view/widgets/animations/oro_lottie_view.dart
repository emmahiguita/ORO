import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OroLottieView extends StatelessWidget {
  final String assetName;
  final double? width;
  final double? height;
  final BoxFit fit;
  final bool repeat;
  final bool reverse;
  final bool animate;
  final AlignmentGeometry alignment;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;

  const OroLottieView({
    super.key,
    required this.assetName,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.repeat = true,
    this.reverse = false,
    this.animate = true,
    this.alignment = Alignment.center,
    this.errorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      assetName,
      width: width,
      height: height,
      fit: fit,
      repeat: repeat,
      reverse: reverse,
      animate: animate,
      alignment: alignment,
      frameBuilder: (context, child, composition) {
        if (composition == null) {
          return SizedBox(
            width: width ?? 60,
            height: height ?? 60,
            child: const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          );
        }
        return child;
      },
      errorBuilder: errorBuilder ??
          (context, error, stackTrace) {
            return SizedBox(
              width: width ?? 80,
              height: height ?? 80,
              child: Center(
                child: Icon(
                  Icons.animation_rounded,
                  size: (width ?? 80) * 0.45,
                  color: Theme.of(context)
                      .colorScheme
                      .primary
                      .withValues(alpha: 0.4),
                ),
              ),
            );
          },
    );
  }
}
