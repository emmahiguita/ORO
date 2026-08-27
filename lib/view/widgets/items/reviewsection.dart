import 'package:flutter/material.dart';
import 'package:oro/controller/items/itemsdetailsController.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/view/widgets/items/featuredreview.dart';
import 'package:oro/view/widgets/items/ratingsummary.dart';
import 'package:oro/view/widgets/items/reviewsectionheader.dart';
import 'package:oro/view/widgets/items/reviewsectionskeleton.dart';

class ReviewSection extends StatelessWidget {
  final ItemsDetailsControllerImp controller;

  const ReviewSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (controller.ratingStatusRequest == StatusRequest.loding) {
      return const ReviewSectionSkeleton();
    } else if (controller.allRating.isEmpty) {
      return Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: .65)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star_border, color: Colors.amber[300], size: 24),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                "Este producto aún no tiene reseñas.",
                style: TextStyle(
                  fontSize: 15,
                  color: theme.colorScheme.onSurface.withValues(alpha: .65),
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border:
            Border.all(color: theme.colorScheme.outline.withValues(alpha: .65)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReviewSectionHeader(controller: controller),
          const SizedBox(height: 20),
          RatingSummary(controller: controller),
          const SizedBox(height: 16),
          FeaturedReview(review: controller.allRating[0]),
        ],
      ),
    );
  }
}
