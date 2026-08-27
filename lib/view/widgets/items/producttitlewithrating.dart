import 'package:flutter/material.dart';
import 'package:oro/controller/items/itemsdetailsController.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/core/functions/databasetranslation.dart';
import 'package:oro/view/widgets/items/ratingbadge.dart';

class ProductTitleWithRating extends StatelessWidget {
  final ItemsDetailsControllerImp controller;

  const ProductTitleWithRating({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            databaseTranslation(
              controller.data.itemName,
              controller.data.itemNameAr,
              controller.data.itemNameEs,
            ),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: OroColors.crystalWhite,
              height: 1.22,
              letterSpacing: -0.3,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Builder(
          builder: (context) {
            final ratingStr = controller.data.itemAvgRating?.toString();
            final ratingVal = double.tryParse(ratingStr ?? '0') ?? 0.0;
            if (ratingVal > 0) {
              return RatingBadge(rating: ratingStr ?? '0');
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
