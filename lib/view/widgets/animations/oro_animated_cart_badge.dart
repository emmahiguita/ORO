import 'package:flutter/material.dart';
import 'package:oro/core/constant/color.dart';

class OroAnimatedCartBadge extends StatefulWidget {
  final int count;
  final Widget child;
  final Color badgeColor;
  final Color textColor;
  final double top;
  final double right;

  const OroAnimatedCartBadge({
    super.key,
    required this.count,
    required this.child,
    this.badgeColor = Appcolor.oxblood,
    this.textColor = Colors.white,
    this.top = 4,
    this.right = 4,
  });

  @override
  State<OroAnimatedCartBadge> createState() => _OroAnimatedCartBadgeState();
}

class _OroAnimatedCartBadgeState extends State<OroAnimatedCartBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  int _lastCount = 0;

  @override
  void initState() {
    super.initState();
    _lastCount = widget.count;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.4), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.4, end: 0.9), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 0.9, end: 1.0), weight: 30),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
  }

  @override
  void didUpdateWidget(covariant OroAnimatedCartBadge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.count != _lastCount && widget.count > 0) {
      _lastCount = widget.count;
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        widget.child,
        if (widget.count > 0)
          Positioned(
            top: widget.top,
            right: widget.right,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                constraints: const BoxConstraints(
                  minWidth: 18,
                  minHeight: 18,
                ),
                decoration: BoxDecoration(
                  color: widget.badgeColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: widget.badgeColor.withValues(alpha: 0.4),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    widget.count > 99 ? '99+' : '${widget.count}',
                    style: TextStyle(
                      color: widget.textColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      height: 1.1,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
