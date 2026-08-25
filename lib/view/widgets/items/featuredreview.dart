import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jiffy/jiffy.dart';
import 'package:oro/apilink.dart';

class FeaturedReview extends StatelessWidget {
  final dynamic review;

  const FeaturedReview({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final userPfp = review.userPfp?.toString() ?? '';
    final userName = review.userName?.toString() ?? 'Usuario';
    final stars = double.tryParse(review.ratingStars?.toString() ?? '') ?? 5.0;
    final comment = review.ratingComment?.toString() ?? '';
    final dateStr = review.ratingDatetime?.toString();
    String formattedTime = '';
    if (dateStr != null && dateStr.isNotEmpty) {
      try {
        formattedTime = Jiffy.parse(dateStr).fromNow();
      } catch (_) {
        formattedTime = '';
      }
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? theme.colorScheme.onSurface.withValues(alpha: 0.05)
            : Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.onSurface.withValues(alpha: isDark ? 0.1 : 0.12),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.grey[200],
            backgroundImage: userPfp.isNotEmpty
                ? CachedNetworkImageProvider(AppLink.pfpimage + userPfp)
                : null,
            child: userPfp.isEmpty
                ? Icon(Icons.person, color: Colors.grey[400])
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        userName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    RatingBarIndicator(
                      rating: stars,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 16,
                    ),
                  ],
                ),
                if (formattedTime.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    formattedTime,
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),
                ],
                if (comment.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    comment,
                    style: TextStyle(
                      color: Colors.grey[800],
                      height: 1.4,
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
