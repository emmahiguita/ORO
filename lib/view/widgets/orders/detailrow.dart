import 'package:flutter/material.dart';
import 'package:oro/core/constant/color.dart';

class DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;
  const DetailRow(
      {super.key,
      required this.label,
      required this.value,
      required this.isTotal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: isTotal ? FontWeight.normal : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Appcolor.berry : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
