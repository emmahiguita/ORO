import 'package:flutter/material.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/address/gradientprogressindicator.dart';

class AcceptOrderButton extends StatelessWidget {
  final bool loading;
  final VoidCallback? onPressed;

  const AcceptOrderButton({
    super.key,
    required this.loading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: loading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: GradientProgressIndicator(strokeWidth: 2))
          : const Icon(
              Icons.check_circle_outline,
              size: 18,
              color: Colors.white,
            ),
      label: const Text('Accept Order'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Appcolor.berry,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
