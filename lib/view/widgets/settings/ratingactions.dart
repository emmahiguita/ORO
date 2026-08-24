import 'package:flutter/material.dart';
import 'package:oro/controller/setting/viewratingcontroller.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/settings/actionbutton.dart';

class RatingActions extends StatelessWidget {
  final ViewRatingControllerImp controller;
  final dynamic rating;

  const RatingActions({
    super.key,
    required this.controller,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ActionButton(
          icon: Icons.visibility_outlined,
          color: Appcolor.berry,
          tooltip: "View item details",
          onPressed: () => controller.goToItemDetails(rating),
        ),
        const SizedBox(width: 8),
        ActionButton(
          icon: Icons.delete_outline,
          color: Colors.red[400]!,
          tooltip: "Delete rating",
          onPressed: () => controller.deleteRating(
              rating.ratingId.toString(), controller.allRating.indexOf(rating)),
        ),
      ],
    );
  }
}
