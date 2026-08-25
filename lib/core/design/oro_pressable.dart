import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oro/core/design/oro_motion.dart';

/// Interactive touch component providing subtle scale (0.985) and haptic feedback.
class OroPressable extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double pressedScale;
  final bool enableHaptic;
  final HitTestBehavior behavior;

  const OroPressable({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.pressedScale = 0.985,
    this.enableHaptic = true,
    this.behavior = HitTestBehavior.opaque,
  });

  @override
  State<OroPressable> createState() => _OroPressableState();
}

class _OroPressableState extends State<OroPressable> {
  bool _pressed = false;

  void _onTapDown(TapDownDetails _) {
    if (widget.onTap == null && widget.onLongPress == null) return;
    setState(() => _pressed = true);
    if (widget.enableHaptic) {
      HapticFeedback.selectionClick();
    }
  }

  void _onTapUp(TapUpDetails _) {
    if (_pressed) {
      setState(() => _pressed = false);
    }
  }

  void _onTapCancel() {
    if (_pressed) {
      setState(() => _pressed = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final reduce = OroMotion.reduceMotion(context);
    return GestureDetector(
      behavior: widget.behavior,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: AnimatedScale(
        scale: reduce ? 1.0 : (_pressed ? widget.pressedScale : 1.0),
        duration: OroMotion.adaptive(context, OroMotion.fast),
        curve: OroMotion.standard,
        child: widget.child,
      ),
    );
  }
}
