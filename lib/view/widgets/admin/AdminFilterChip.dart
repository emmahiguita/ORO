import 'package:flutter/material.dart';

import 'package:oro/core/constant/color.dart';

class AdminFilterChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final Function(bool) onSelected;
  const AdminFilterChip({
    super.key,
    required this.label,
    required this.icon,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Row(
        children: [
          Icon(icon,
              size: 16, color: selected ? Appcolor.berry : Colors.grey[600]),
          const SizedBox(width: 4),
          Text(label),
        ],
      ),
      selected: selected,
      onSelected: onSelected,
      backgroundColor: Colors.grey[50],
      selectedColor: Appcolor.berry.withValues(alpha: 0.1),
      checkmarkColor: Appcolor.berry,
      labelStyle: TextStyle(
        fontSize: 13,
        color: selected ? Appcolor.berry : Colors.grey[700],
        fontWeight: FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: selected
              ? Appcolor.berry.withValues(alpha: 0.3)
              : Colors.grey[300]!,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
