import 'package:flutter/material.dart';

class AUTHTText extends StatelessWidget {
  final String text;
  const AUTHTText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headlineLarge,
      textAlign: TextAlign.center,
    );
  }
}
