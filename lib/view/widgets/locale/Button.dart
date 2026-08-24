import 'package:flutter/material.dart';
import 'package:oro/core/constant/color.dart';

class LCButon extends StatelessWidget {
  final String text;
  final Function()? onPressed;

  const LCButon({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Appcolor.rosePompadour,
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
