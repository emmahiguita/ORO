import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:oro/controller/items/itemsdetailsController.dart';
import 'package:oro/core/design/oro_colors.dart';
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
      margin: const EdgeInsets.fromLTRB(16, 6, 16, 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  OroColors.nightBlue.withValues(alpha: 0.90),
                  OroColors.surfaceDarkElevated.withValues(alpha: 0.82),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.20),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.30),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductTitleWithRating(controller: controller),
                const SizedBox(height: 14),
                ProductDescription(
                  description: databaseTranslation(
                    controller.data.itemDesc,
                    controller.data.itemDescAr,
                    controller.data.itemDescEs,
                  ),
                ),
                const SizedBox(height: 18),
                ActionRow(controller: controller),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
