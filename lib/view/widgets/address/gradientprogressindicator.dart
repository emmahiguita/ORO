import 'dart:math';

import 'package:flutter/material.dart';
import 'package:oro/core/constant/color.dart';

class GradientProgressIndicator extends StatefulWidget {
  final double strokeWidth;
  const GradientProgressIndicator({super.key, required this.strokeWidth});

  @override
  State<GradientProgressIndicator> createState() =>
      _GradientProgressIndicatorState();
}

class _GradientProgressIndicatorState extends State<GradientProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return CustomPaint(
          painter: GradientArcPainter(
            widget.strokeWidth,
            arcRotation: _controller.value,
            gradientRotation: _controller.value * 2,
          ),
          size: const Size(60, 60),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class GradientArcPainter extends CustomPainter {
  final double arcRotation;
  final double gradientRotation;
  final double strokeWidth;

  GradientArcPainter(
    this.strokeWidth, {
    required this.arcRotation,
    required this.gradientRotation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = size.center(Offset.zero);
    final radius = min(size.width, size.height) / 2;
    final sweepAngle = pi * 1.5;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        startAngle: 0,
        endAngle: 2 * pi,
        colors: const [
          Appcolor.amaranthpink,
          Appcolor.pink,
          Appcolor.berry,
          Appcolor.deepPink,
          Appcolor.amaranthpink,
        ],
        stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
        transform: GradientRotation(2 * pi * gradientRotation),
      ).createShader(rect);

    final startAngle = 2 * pi * arcRotation;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant GradientArcPainter oldDelegate) {
    return oldDelegate.arcRotation != arcRotation ||
        oldDelegate.gradientRotation != gradientRotation;
  }
}
