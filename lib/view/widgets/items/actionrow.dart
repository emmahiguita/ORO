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
        AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          curve: Curves.elasticOut,
          height: controller.isOrdered ? 56 : 0,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1.0, 0.0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.elasticOut,
                )),
                child: FadeTransition(opacity: animation, child: child),
              );
            },
            child: controller.isOrdered
                ? SizedBox(
                    width: double.infinity,
                    child: MovingGradientReviewButton(
                      key: const ValueKey('review_button'),
                      onPressed: () => controller.showReviewDialog(),
                    ),
                  )
                : const SizedBox(key: ValueKey('empty')),
          ),
        ),
        if (controller.isOrdered) const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FavoriteButton(controller: controller),
            const SizedBox(width: 16),
            QuantityControls(controller: controller),
          ],
        ),
      ],
    );
  }
}
