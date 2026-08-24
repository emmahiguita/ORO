import 'package:flutter/material.dart';
import 'package:oro/core/constant/color.dart';

class OfferSectionHeader extends StatelessWidget {
  final bool isLoading;
  final String title;
  const OfferSectionHeader(
      {super.key, required this.isLoading, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(
            color: isLoading ? Colors.grey[300] : Appcolor.berry,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
