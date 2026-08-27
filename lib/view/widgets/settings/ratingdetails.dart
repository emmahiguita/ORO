import 'package:flutter/material.dart';
import 'package:oro/view/widgets/settings/itemname.dart';
import 'package:oro/view/widgets/settings/ratingcomment.dart';
import 'package:oro/view/widgets/settings/ratingstars.dart';

class RatingDetails extends StatelessWidget {
  final dynamic rating;

  const RatingDetails({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    final itemName = rating.itemName?.toString() ?? '';
    final ratingStars = (rating.ratingStars is num)
        ? rating.ratingStars as num
        : (double.tryParse(rating.ratingStars?.toString() ?? '0') ?? 0);
    final comment = rating.ratingComment?.toString() ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (itemName.isNotEmpty) ItemName(name: itemName),
        const SizedBox(height: 12),
        RatingStars(stars: ratingStars.toString()),
        if (comment.trim().isNotEmpty) ...[
          const SizedBox(height: 16),
          RatingComment(comment: comment),
        ],
      ],
    );
  }
}
