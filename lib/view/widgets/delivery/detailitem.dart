import 'package:flutter/material.dart';
import 'package:oro/core/constant/color.dart';

class DetailItem extends StatelessWidget {
  final String label;
  final String value;
  final bool isPrice;

  const DetailItem({
    super.key,
    required this.label,
    required this.value,
    required this.isPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: isPrice ? Appcolor.berry : Colors.black87,
          ),
        ),
      ],
    );
  }
}
