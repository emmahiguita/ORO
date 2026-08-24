import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:oro/core/constant/color.dart';

class InfoSection extends StatelessWidget {
  final bool isLoading;
  const InfoSection({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Appcolor.berry.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.info_outline,
                    color: Appcolor.berry,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'About Offer Management',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (isLoading) ...[
              _buildShimmerText(),
              const SizedBox(height: 8),
              _buildShimmerText(width: 0.8),
              const SizedBox(height: 8),
              _buildShimmerText(width: 0.6),
            ] else ...[
              const Text(
                'This offer will be displayed on the main page of your application. Users will see this promotional content when they first open the app.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                '• Tap "Edit Offer" to modify the content\n'
                '• Pull down to refresh the data\n'
                '• Changes are reflected immediately',
                style: TextStyle(
                  fontSize: 13,
                  height: 1.4,
                  color: Colors.black45,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

Widget _buildShimmerText({double width = 1.0}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      width: double.infinity * width,
      height: 12,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
    ),
  );
}
