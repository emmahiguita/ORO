import 'package:flutter/material.dart';
import 'package:oro/core/design/oro_motion.dart';

/// Wraps a [child] with a staggered fade + slide-up entrance animation.
///
/// Each item in a list should receive a unique [index] so they appear
/// sequentially. Pass [delayBase] to control the stagger step in ms.
class OroStaggeredItem extends StatefulWidget {
  final Widget child;

  /// Zero-based position in the list; drives the stagger delay.
  final int index;

  /// Delay added per index step (default 40 ms).
  final int delayBase;

  const OroStaggeredItem({
    super.key,
    required this.child,
    required this.index,
    this.delayBase = 40,
  });

  @override
  State<OroStaggeredItem> createState() => _OroStaggeredItemState();
}

class _OroStaggeredItemState extends State<OroStaggeredItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: OroMotion.slow,
    );

    _opacity = CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.0, 0.8, curve: Curves.easeOutCubic),
    ));

    // Stagger: cap max delay at 480 ms so long lists don't feel sluggish.
    final delay = (widget.index * widget.delayBase).clamp(0, 480);
    Future.delayed(Duration(milliseconds: delay), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (OroMotion.reduceMotion(context)) return widget.child;
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _slide,
        child: widget.child,
      ),
    );
  }
}
