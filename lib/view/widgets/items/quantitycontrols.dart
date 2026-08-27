import 'package:flutter/material.dart';
import 'package:oro/controller/items/itemsdetailsController.dart';
import 'package:oro/view/widgets/items/quantitybutton.dart';

class QuantityControls extends StatelessWidget {
  final ItemsDetailsControllerImp controller;

  const QuantityControls({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(25),
        border:
            Border.all(color: theme.colorScheme.outline.withValues(alpha: .7)),
      ),
      child: Row(
        children: [
          QuantityButton(
            icon: Icons.remove_rounded,
            onTap: controller.remove,
          ),
          Container(
            width: 50,
            height: 36,
            alignment: Alignment.center,
            child: Text(
              "${controller.counter}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          QuantityButton(
            icon: Icons.add_rounded,
            onTap: controller.add,
          ),
        ],
      ),
    );
  }
}
