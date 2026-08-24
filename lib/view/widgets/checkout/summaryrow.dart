import 'package:flutter/material.dart';
import 'package:oro/core/constant/color.dart';

class SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;
  const SummaryRow(
      {super.key,
      required this.label,
      required this.value,
      required this.isTotal});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: "Sw",
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 16 : 14,
            color: isTotal ? Appcolor.deepPink : Colors.black,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: "Sw",
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 18 : 14,
            color: isTotal ? Appcolor.deepPink : Colors.black,
          ),
        ),
      ],
    );
  }
}
