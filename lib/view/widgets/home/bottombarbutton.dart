import 'package:flutter/material.dart';

class BottomBarButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData iconData;
  final String text;
  final bool isActive;

  const BottomBarButton({
    super.key,
    required this.onPressed,
    required this.iconData,
    required this.text,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final active = theme.colorScheme.primary;
    final inactive = theme.colorScheme.onSurface.withValues(alpha: .52);

    return Semantics(
      selected: isActive,
      button: true,
      label: text,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: BoxDecoration(
            color: isActive
                ? theme.colorScheme.secondary.withValues(alpha: .13)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: isActive ? 1.05 : 1,
                duration: const Duration(milliseconds: 220),
                child: Icon(
                  iconData,
                  size: 20,
                  color: isActive ? active : inactive,
                ),
              ),
              const SizedBox(height: 1),
              Flexible(
                child: Text(
                  text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: isActive ? active : inactive,
                    fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
