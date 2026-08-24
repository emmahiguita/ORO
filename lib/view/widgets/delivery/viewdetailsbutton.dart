import 'package:flutter/material.dart';
import 'package:oro/core/constant/color.dart';

class ViewDetailsButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ViewDetailsButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Appcolor.berry.withValues(alpha: 0.3)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed,
          child: Container(
            alignment: Alignment.center,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.visibility_outlined,
                  size: 18,
                  color: Appcolor.berry,
                ),
                SizedBox(width: 8),
                Text(
                  'View Details',
                  style: TextStyle(
                    fontSize: 14,
                    color: Appcolor.berry,
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
