import 'package:flutter/material.dart';
import 'package:oro/core/constant/color.dart';

class DoOrDont extends StatelessWidget {
  final String auth;
  final String text;
  final void Function()? onTap;
  const DoOrDont(
      {super.key, required this.auth, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(text),
        InkWell(
          onTap: onTap,
          child: Text(
            auth,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Appcolor.accentGold),
          ),
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}

// Retrocompatibilidad con código existente
// ignore: camel_case_types
typedef dodont = DoOrDont;
