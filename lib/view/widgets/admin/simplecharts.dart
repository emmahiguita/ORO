import 'dart:math' as math;
import 'package:flutter/material.dart';

class PremiumLineChart extends StatelessWidget {
  final List<double> values;
  final List<String> labels;
  final Color color;
  const PremiumLineChart(
      {super.key,
      required this.values,
      required this.labels,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 220,
          width: double.infinity,
          child: CustomPaint(
              painter: _LinePainter(
                  values: values,
                  color: color,
                  gridColor: Theme.of(context).dividerColor)),
        ),
        const SizedBox(height: 8),
        Row(
          children: List.generate(
              labels.length,
              (i) => Expanded(
                    child: Text(labels[i],
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall),
                  )),
        ),
      ],
    );
  }
}

class PremiumBarChart extends StatelessWidget {
  final List<double> values;
  final List<String> labels;
  final Color color;
  const PremiumBarChart(
      {super.key,
      required this.values,
      required this.labels,
      required this.color});

  @override
  Widget build(BuildContext context) {
    final maxValue =
        values.isEmpty ? 1.0 : math.max(1.0, values.reduce(math.max));
    return SizedBox(
      height: 240,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(values.length, (i) {
          final ratio = (values[i] / maxValue).clamp(0.0, 1.0);
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(values[i].toStringAsFixed(values[i] % 1 == 0 ? 0 : 1),
                      style: Theme.of(context).textTheme.labelSmall),
                  const SizedBox(height: 6),
                  Flexible(
                    child: FractionallySizedBox(
                      heightFactor: math.max(.04, ratio),
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [color, color.withValues(alpha: .35)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(8)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(labels[i],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelSmall),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class PremiumDonutChart extends StatelessWidget {
  final List<double> values;
  final List<String> labels;
  final List<Color>? colors;
  final double holeRadius;

  const PremiumDonutChart({
    super.key,
    required this.values,
    required this.labels,
    this.colors,
    this.holeRadius = 0.55,
  });

  static const List<Color> defaultPalette = [
    Color(0xFFC6A15B), // Gold
    Color(0xFF29443A), // Forest
    Color(0xFFA4604D), // Clay
    Color(0xFF26364A), // Navy
    Color(0xFF60415E), // Plum
    Color(0xFF71806A), // Sage
    Color(0xFF806448), // Bronze
    Color(0xFF2E6A4B), // Success
  ];

  @override
  Widget build(BuildContext context) {
    final total = values.fold<double>(0, (sum, val) => sum + val);
    if (total <= 0) {
      return const SizedBox(
        height: 200,
        child: Center(child: Text('Sin datos disponibles')),
      );
    }

    final palette = colors ?? defaultPalette;

    return Column(
      children: [
        SizedBox(
          height: 180,
          width: 180,
          child: CustomPaint(
            painter: _DonutPainter(
              values: values,
              colors: palette,
              holeRadius: holeRadius,
              dividerColor: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: List.generate(labels.length, (i) {
            final color = palette[i % palette.length];
            final percent = total > 0
                ? ((values[i] / total) * 100).toStringAsFixed(1)
                : '0';
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  '${labels[i]} ($percent%)',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}

class _LinePainter extends CustomPainter {
  final List<double> values;
  final Color color;
  final Color gridColor;
  _LinePainter(
      {required this.values, required this.color, required this.gridColor});

  @override
  void paint(Canvas canvas, Size size) {
    final grid = Paint()
      ..color = gridColor
      ..strokeWidth = 1;
    for (var i = 1; i < 4; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
    if (values.isEmpty) return;
    final maxValue = math.max(1.0, values.reduce(math.max));
    final minValue = values.reduce(math.min);
    final range = math.max(1.0, maxValue - minValue);
    Offset point(int i) {
      final x = values.length == 1
          ? size.width / 2
          : size.width * i / (values.length - 1);
      final y = size.height -
          ((values[i] - minValue) / range) * (size.height - 16) -
          8;
      return Offset(x, y);
    }

    final path = Path()..moveTo(point(0).dx, point(0).dy);
    for (var i = 1; i < values.length; i++) {
      path.lineTo(point(i).dx, point(i).dy);
    }
    canvas.drawPath(
        path,
        Paint()
          ..color = color
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round);
    final dot = Paint()..color = color;
    for (var i = 0; i < values.length; i++) {
      canvas.drawCircle(point(i), 4, dot);
    }
  }

  @override
  bool shouldRepaint(covariant _LinePainter oldDelegate) =>
      oldDelegate.values != values ||
      oldDelegate.color != color ||
      oldDelegate.gridColor != gridColor;
}

class _DonutPainter extends CustomPainter {
  final List<double> values;
  final List<Color> colors;
  final double holeRadius;
  final Color dividerColor;

  _DonutPainter({
    required this.values,
    required this.colors,
    required this.holeRadius,
    required this.dividerColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final total = values.fold<double>(0, (sum, val) => sum + val);
    if (total <= 0) return;

    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = math.min(size.width, size.height) / 2;
    final innerRadius = outerRadius * holeRadius;
    final rect = Rect.fromCircle(center: center, radius: outerRadius);

    double startAngle = -math.pi / 2;

    for (var i = 0; i < values.length; i++) {
      final sweepAngle = (values[i] / total) * 2 * math.pi;
      if (sweepAngle <= 0) continue;

      final paint = Paint()
        ..color = colors[i % colors.length]
        ..style = PaintingStyle.fill;

      final path = Path()
        ..arcTo(rect, startAngle, sweepAngle, false)
        ..arcTo(Rect.fromCircle(center: center, radius: innerRadius),
            startAngle + sweepAngle, -sweepAngle, false)
        ..close();

      canvas.drawPath(path, paint);

      if (values.length > 1) {
        final dividerPaint = Paint()
          ..color = dividerColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;
        canvas.drawPath(path, dividerPaint);
      }

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant _DonutPainter oldDelegate) =>
      oldDelegate.values != values ||
      oldDelegate.colors != colors ||
      oldDelegate.holeRadius != holeRadius ||
      oldDelegate.dividerColor != dividerColor;
}
