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
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
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
          const SizedBox(height: 24),
          ActionRow(controller: controller),
        ],
      ),
    );
  }
}
