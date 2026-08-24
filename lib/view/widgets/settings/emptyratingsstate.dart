import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/core/constant/color.dart';

class EmptyRatingsState extends StatelessWidget {
  const EmptyRatingsState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              Icons.star_border_rounded,
              size: 64,
              color: Appcolor.berry.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'No ratings yet',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2D3748),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Start rating items to see them here',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.explore_outlined),
            label: const Text('Explore Items'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Appcolor.berry,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 2,
            ),
          ),
        ],
      ),
    );
  }
}
