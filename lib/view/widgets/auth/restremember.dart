import 'package:flutter/material.dart';
import 'package:oro/core/constant/color.dart';

class Restremember extends StatelessWidget {
  final void Function()? onTap;
  final bool rememberMe;
  final void Function(bool? value)? onChanged;

  const Restremember({
    super.key,
    required this.onTap,
    required this.rememberMe,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: InkWell(
              onTap: () => onChanged?.call(!rememberMe),
              borderRadius: BorderRadius.circular(8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: rememberMe,
                    activeColor: Appcolor.berry,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    onChanged: onChanged,
                  ),
                  Flexible(
                    child: Text(
                      "Recordarme",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: Text(
                "¿Olvidaste tu clave?",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Appcolor.berry,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
