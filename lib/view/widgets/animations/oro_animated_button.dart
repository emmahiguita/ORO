import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oro/core/constant/color.dart';

class OroAnimatedButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final double? width;
  final double height;
  final Color? backgroundColor;
  final Color? textColor;
  final List<Color>? gradientColors;
  final BorderRadius? borderRadius;
  final bool isOutlined;
  final EdgeInsetsGeometry padding;

  const OroAnimatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.width,
    this.height = 52,
    this.backgroundColor,
    this.textColor,
    this.gradientColors,
    this.borderRadius,
    this.isOutlined = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
  });

  @override
  State<OroAnimatedButton> createState() => _OroAnimatedButtonState();
}

class _OroAnimatedButtonState extends State<OroAnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      _controller.forward();
      HapticFeedback.lightImpact();
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      _controller.reverse();
    }
  }

  void _onTapCancel() {
    if (widget.onPressed != null && !widget.isLoading) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEnabled = widget.onPressed != null && !widget.isLoading;
    final r = widget.borderRadius ?? BorderRadius.circular(16);

    final defaultGrad = widget.gradientColors ??
        const [
          Appcolor.berry,
          Appcolor.oxblood,
        ];

    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        onTap: isEnabled
            ? () {
                HapticFeedback.mediumImpact();
                widget.onPressed!();
              }
            : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.width ?? double.infinity,
          height: widget.height,
          padding: widget.padding,
          decoration: BoxDecoration(
            borderRadius: r,
            color: widget.isOutlined
                ? Colors.transparent
                : (widget.backgroundColor ??
                    (widget.gradientColors == null
                        ? null
                        : Colors.transparent)),
            gradient: widget.isOutlined || widget.backgroundColor != null
                ? null
                : LinearGradient(
                    colors: isEnabled
                        ? defaultGrad
                        : [
                            Colors.grey.shade400,
                            Colors.grey.shade500,
                          ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            border: widget.isOutlined
                ? Border.all(
                    color: isEnabled
                        ? (widget.textColor ?? Appcolor.berry)
                        : Colors.grey.shade400,
                    width: 1.5,
                  )
                : null,
            boxShadow: isEnabled && !widget.isOutlined
                ? [
                    BoxShadow(
                      color: (defaultGrad.first).withValues(alpha: 0.28),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: widget.isLoading
                ? SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        widget.isOutlined
                            ? (widget.textColor ?? Appcolor.berry)
                            : Colors.white,
                      ),
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.icon != null) ...[
                        Icon(
                          widget.icon,
                          size: 20,
                          color: widget.isOutlined
                              ? (widget.textColor ?? Appcolor.berry)
                              : (widget.textColor ?? Colors.white),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Flexible(
                        child: Text(
                          widget.text,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: widget.isOutlined
                                ? (widget.textColor ?? Appcolor.berry)
                                : (widget.textColor ?? Colors.white),
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
