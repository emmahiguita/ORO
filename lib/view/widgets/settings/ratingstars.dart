import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:oro/core/constant/color.dart';

class RatingStars extends StatelessWidget {
  final String stars;

  const RatingStars({super.key, required this.stars});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingBarIndicator(
          rating: double.tryParse(stars) ?? 0.0,
          itemBuilder: (context, index) => const Icon(
            Icons.star_rounded,
            color: Appcolor.amaranthpink,
          ),
          itemCount: 5,
          itemSize: 22.0,
          unratedColor: Colors.grey[300],
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: Appcolor.berry.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            stars,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Appcolor.berry,
            ),
          ),
        ),
      ],
    );
  }
}
