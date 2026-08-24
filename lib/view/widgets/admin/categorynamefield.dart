import 'package:flutter/material.dart';

class CategoryNameField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String labelText;
  final Widget prefixIcon;
  final TextDirection textDirection;
  const CategoryNameField(
      {super.key,
      required this.controller,
      required this.validator,
      required this.prefixIcon,
      required this.labelText,
      required this.textDirection});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: prefixIcon,
      ),
      textDirection: textDirection,
    );
  }
}
