import 'package:flutter/material.dart';
import 'package:oro/core/constant/color.dart';

class ResendButton extends StatelessWidget {
  final Function()? onTap;
  const ResendButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 335,
      child: Stack(
        children: [
          // Your other widgets here

          Positioned(
            bottom: 0, // adjust as needed
            left: MediaQuery.of(context).size.width / 2 - 60,
            child: InkWell(
              onTap: onTap,
              child: Text(
                "Reenviar código",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Appcolor.rosePompadour,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    const Shadow(
                        color: Colors.black12,
                        offset: Offset(2, 2),
                        blurRadius: 3)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
