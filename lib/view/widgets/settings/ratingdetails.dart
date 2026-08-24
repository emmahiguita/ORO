import 'package:flutter/material.dart';
import 'package:oro/view/widgets/settings/itemname.dart';
import 'package:oro/view/widgets/settings/ratingcomment.dart';
import 'package:oro/view/widgets/settings/ratingstars.dart';

class RatingDetails extends StatelessWidget {
  final dynamic rating;

  const RatingDetails({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ItemName(name: rating.itemName!),
        const SizedBox(height: 12),
        RatingStars(stars: rating.ratingStars!),
        if (rating.ratingComment!.isNotEmpty) ...[
          const SizedBox(height: 16),
          RatingComment(comment: rating.ratingComment!),
        ],
      ],
    );
  }
}
