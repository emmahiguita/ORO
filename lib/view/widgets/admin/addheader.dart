import 'package:flutter/material.dart';
import 'package:oro/core/constant/color.dart';

class AddHeader extends StatelessWidget {
  final String title;
  const AddHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Appcolor.berry,
        ),
      ),
    );
  }
}
