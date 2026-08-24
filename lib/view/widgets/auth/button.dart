import 'package:flutter/material.dart';

class AUTHButton extends StatelessWidget {
  final String text;
  final void Function() ontap;

  const AUTHButton({
    super.key,
    required this.text,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: SizedBox(
        width: double.infinity,
        child: FilledButton(
          onPressed: ontap,
          child: Text(text),
        ),
      ),
    );
  }
}
