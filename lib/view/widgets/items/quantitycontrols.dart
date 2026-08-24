import 'package:flutter/material.dart';
import 'package:oro/controller/items/itemsdetailsController.dart';
import 'package:oro/view/widgets/items/quantitybutton.dart';

class QuantityControls extends StatelessWidget {
  final ItemsDetailsControllerImp controller;

  const QuantityControls({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey[200]!),
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
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
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
