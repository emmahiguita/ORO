import 'package:flutter/material.dart';
import 'package:oro/controller/items/itemsdetailsController.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/view/widgets/items/quantitybutton.dart';

class QuantityControls extends StatelessWidget {
  final ItemsDetailsControllerImp controller;

  const QuantityControls({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFF132738),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: OroColors.accentGold.withValues(alpha: 0.60),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          QuantityButton(
            icon: Icons.remove_rounded,
            onTap: controller.remove,
          ),
          Container(
            width: 44,
            height: 34,
            alignment: Alignment.center,
            child: Text(
              "${controller.counter}",
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w900,
                color: OroColors.crystalWhite,
                letterSpacing: 0.5,
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
