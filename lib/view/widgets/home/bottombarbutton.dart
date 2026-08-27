import 'package:flutter/material.dart';
import 'package:oro/core/design/oro_colors.dart';

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
    final active = OroColors.forest;
    final inactive = theme.colorScheme.onSurface.withValues(alpha: .46);

    return Semantics(
      selected: isActive,
      button: true,
      label: text,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
          decoration: BoxDecoration(
            color: isActive ? OroColors.forestSoft : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: isActive ? 1.05 : 1,
                duration: const Duration(milliseconds: 160),
                child: Icon(
                  iconData,
                  size: 19,
                  color: isActive ? active : inactive,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: isActive ? active : inactive,
                  fontSize: 8.5,
                  fontWeight: isActive ? FontWeight.w900 : FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
