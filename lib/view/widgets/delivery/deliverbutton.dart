import 'package:flutter/material.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/address/gradientprogressindicator.dart';

class DeliverButton extends StatelessWidget {
  final bool loading;
  final VoidCallback? onPressed;

  const DeliverButton({
    super.key,
    required this.loading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: loading
              ? [
                  Appcolor.grey,
                  Appcolor.grey.withValues(alpha: 0.8),
                ]
              : [
                  Appcolor.berry,
                  Appcolor.berry.withValues(alpha: 0.8),
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: loading
                ? Appcolor.grey.withValues(alpha: 0.3)
                : Appcolor.berry.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed,
          child: Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: GradientProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(
                        Icons.check_circle_outline,
                        size: 18,
                        color: Colors.white,
                      ),
                const SizedBox(width: 8),
                const Text(
                  'Mark Delivered',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
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
