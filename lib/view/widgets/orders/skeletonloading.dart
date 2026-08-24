import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:oro/view/widgets/orders/skeletonbox.dart';

class SkeletonLoading extends StatelessWidget {
  const SkeletonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 3,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header skeleton
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonBox(width: 80, height: 24),
                      SkeletonBox(width: 60, height: 16),
                    ],
                  ),
                  SizedBox(height: 12),
                  // Details skeleton
                  SkeletonDetailRow(),
                  SkeletonDetailRow(),
                  SkeletonDetailRow(),
                  SkeletonDetailRow(),
                  SizedBox(height: 12),
                  // Button skeleton
                  Align(
                    alignment: Alignment.centerRight,
                    child: SkeletonBox(width: 120, height: 36),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
