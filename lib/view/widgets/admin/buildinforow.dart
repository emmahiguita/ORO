import 'package:flutter/material.dart';

class BuildInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isWarning;

  const BuildInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.isWarning = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: isWarning ? Colors.orange : Colors.grey[600],
        ),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isWarning ? Colors.orange : Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
