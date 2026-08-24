import 'package:flutter/material.dart';

class AUTHForm extends StatelessWidget {
  final String label;
  final IconData icon;
  final String hint;
  final String? Function(String?)? validator;
  final String type;
  final bool? obscureText;
  final void Function()? onTap;
  final TextEditingController controller;

  const AUTHForm({
    super.key,
    required this.label,
    required this.icon,
    required this.hint,
    required this.controller,
    required this.validator,
    required this.type,
    this.obscureText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        keyboardType: type == 'phone'
            ? TextInputType.phone
            : type == 'email'
                ? TextInputType.emailAddress
                : TextInputType.text,
        obscureText: obscureText ?? false,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          suffixIcon: IconButton(
            splashRadius: 20,
            onPressed: onTap,
            icon: Icon(icon),
          ),
        ),
      ),
    );
  }
}
