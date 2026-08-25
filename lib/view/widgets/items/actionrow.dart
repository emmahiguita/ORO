import 'package:flutter/material.dart';
import 'package:oro/controller/items/itemsdetailsController.dart';
import 'package:oro/view/widgets/items/addreviewbutton.dart';
import 'package:oro/view/widgets/items/favoritebutton.dart';
import 'package:oro/view/widgets/items/quantitycontrols.dart';

class ActionRow extends StatelessWidget {
  final ItemsDetailsControllerImp controller;

  const ActionRow({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (controller.isOrdered)
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            clipBehavior: Clip.hardEdge,
            height: 54,
            decoration: const BoxDecoration(),
            child: SizedBox(
              width: double.infinity,
              child: MovingGradientReviewButton(
                key: const ValueKey('review_button'),
                onPressed: () => controller.showReviewDialog(),
              ),
            ),
          ),
        if (controller.isOrdered) const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FavoriteButton(controller: controller),
            QuantityControls(controller: controller),
          ],
        ),
      ],
    );
  }
}
