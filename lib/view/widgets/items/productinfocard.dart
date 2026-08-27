import 'package:flutter/material.dart';
import 'package:oro/controller/items/itemsdetailsController.dart';
import 'package:oro/core/functions/databasetranslation.dart';
import 'package:oro/view/widgets/items/actionrow.dart';
import 'package:oro/view/widgets/items/productdescription.dart';
import 'package:oro/view/widgets/items/producttitlewithrating.dart';

class ProductInfoCard extends StatelessWidget {
  final ItemsDetailsControllerImp controller;

  const ProductInfoCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border:
            Border.all(color: theme.colorScheme.outline.withValues(alpha: .65)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductTitleWithRating(controller: controller),
          const SizedBox(height: 16),
          ProductDescription(
            description: databaseTranslation(
              controller.data.itemDesc,
              controller.data.itemDescAr,
              controller.data.itemDescEs,
            ),
          ),
          const SizedBox(height: 20),
          ActionRow(controller: controller),
        ],
      ),
    );
  }
}
