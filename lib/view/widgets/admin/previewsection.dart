import 'package:flutter/material.dart';

import 'package:oro/core/constant/color.dart';

class PreviewSection extends StatelessWidget {
  final dynamic controller;
  const PreviewSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final hasData = (controller.code?.text?.isNotEmpty ?? false) ||
        (controller.discount?.text?.isNotEmpty ?? false);

    if (!hasData) {
      return const SizedBox.shrink();
    } else {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Appcolor.berry.withValues(alpha: 0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.preview,
                  color: Appcolor.berry,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'Current Coupon Preview',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Appcolor.berry,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Appcolor.berry,
                    Appcolor.berry.withValues(alpha: 0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    controller.code?.text?.isNotEmpty ?? false
                        ? controller.code!.text
                        : 'COUPON CODE',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    controller.discount?.text?.isNotEmpty ?? false
                        ? '${controller.discount!.text}% OFF'
                        : 'XX% OFF',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (controller.expirydate?.text?.isNotEmpty ?? false) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Expires: ${controller.formatDisplayDate(controller.expirydate!.text)}',
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
