import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OroProductFlyToCart {
  OroProductFlyToCart._();

  static void run({
    required BuildContext context,
    required GlobalKey startKey,
    required GlobalKey endKey,
    required Widget imageWidget,
    Duration duration = const Duration(milliseconds: 650),
    VoidCallback? onComplete,
  }) {
    final RenderBox? startBox =
        startKey.currentContext?.findRenderObject() as RenderBox?;
    final RenderBox? endBox =
        endKey.currentContext?.findRenderObject() as RenderBox?;

    if (startBox == null || endBox == null) {
      onComplete?.call();
      return;
    }

    final startPosition = startBox.localToGlobal(Offset.zero);
    final endPosition = endBox.localToGlobal(Offset.zero);

    final startSize = startBox.size;
    final endSize = endBox.size;

    final startOffset = Offset(
      startPosition.dx + (startSize.width / 2) - 30,
      startPosition.dy + (startSize.height / 2) - 30,
    );

    final endOffset = Offset(
      endPosition.dx + (endSize.width / 2) - 15,
      endPosition.dy + (endSize.height / 2) - 15,
    );

    final overlayState = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _FlyAnimationWidget(
        startOffset: startOffset,
        endOffset: endOffset,
        imageWidget: imageWidget,
        duration: duration,
        onEnd: () {
          overlayEntry.remove();
          HapticFeedback.mediumImpact();
          onComplete?.call();
        },
      ),
    );

    overlayState.insert(overlayEntry);
  }
}

class _FlyAnimationWidget extends StatefulWidget {
  final Offset startOffset;
  final Offset endOffset;
  final Widget imageWidget;
  final Duration duration;
  final VoidCallback onEnd;

  const _FlyAnimationWidget({
    required this.startOffset,
    required this.endOffset,
    required this.imageWidget,
    required this.duration,
    required this.onEnd,
  });

  @override
  State<_FlyAnimationWidget> createState() => _FlyAnimationWidgetState();
}

class _FlyAnimationWidgetState extends State<_FlyAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progress;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _progress = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onEnd();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Offset _calculateBezier(double t, Offset p0, Offset p2) {
    // Control point for arc trajectory
    final p1 = Offset(
      math.min(p0.dx, p2.dx) - 40,
      math.min(p0.dy, p2.dy) - 120,
    );

    final x = (1 - t) * (1 - t) * p0.dx + 2 * (1 - t) * t * p1.dx + t * t * p2.dx;
    final y = (1 - t) * (1 - t) * p0.dy + 2 * (1 - t) * t * p1.dy + t * t * p2.dy;

    return Offset(x, y);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _progress,
      builder: (context, child) {
        final t = _progress.value;
        final currentPos = _calculateBezier(t, widget.startOffset, widget.endOffset);
        final scale = (1.0 - (t * 0.75)).clamp(0.25, 1.0);
        final opacity = (1.0 - (t * 0.4)).clamp(0.0, 1.0);
        final rotation = t * 2 * math.pi;

        return Positioned(
          left: currentPos.dx,
          top: currentPos.dy,
          child: Opacity(
            opacity: opacity,
            child: Transform.rotate(
              angle: rotation * 0.5,
              child: Transform.scale(
                scale: scale,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.18),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: widget.imageWidget,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
