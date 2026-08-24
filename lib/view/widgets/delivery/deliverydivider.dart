import 'package:flutter/material.dart';

class DeliveryDivider extends StatelessWidget {
  const DeliveryDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 1,
      color: Colors.grey[200],
    );
  }
}
