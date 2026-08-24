import 'package:flutter/material.dart';

class ItemName extends StatelessWidget {
  final String name;

  const ItemName({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18,
        color: Color(0xFF2D3748),
        height: 1.3,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
