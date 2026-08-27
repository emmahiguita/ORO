import 'package:flutter/material.dart';
import 'package:oro/controller/items/itemsdetailsController.dart';

class RatingSummary extends StatelessWidget {
  final ItemsDetailsControllerImp controller;

  const RatingSummary({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final avgRating =
        double.tryParse(controller.data.itemAvgRating?.toString() ?? '') ?? 5.0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.amber[50]!, Colors.orange[50]!],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.star_rounded, color: Colors.amber, size: 32),
          const SizedBox(width: 12),
          Text(
            avgRating.toStringAsFixed(1),
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.amber,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            "(${controller.allRating.length} reviews)",
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
