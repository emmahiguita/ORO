import 'package:flutter/material.dart';
import 'package:oro/apilink.dart';
import 'package:oro/controller/items/itemsdetailsController.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/common/oro_product_image.dart';
import 'package:oro/view/widgets/items/discountbadge.dart';
import 'package:oro/view/widgets/items/pricetags.dart';

class ProductImageSection extends StatelessWidget {
  final ItemsDetailsControllerImp controller;

  const ProductImageSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: controller.data.itemId!,
      child: Container(
        height: 400,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black.withValues(alpha: 0.8),
              Colors.grey[100]!,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.0, 0.7],
          ),
        ),
        child: Stack(
          children: [
            // Main product image
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 80),
                child: OroProductImage(
                  imageUrl: controller.data.itemImg,
                  productName: controller.data.itemName,
                  categoryName: controller.data.categoryName,
                  fit: BoxFit.contain,
                  height: 280,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),

            // Price tags with improved design
            Positioned(
              bottom: 30,
              right: 20,
              child: PriceTags(controller: controller),
            ),

            // Discount badge
            if (controller.data.itemDiscount! > 0)
              Positioned(
                top: 100,
                left: 20,
                child: DiscountBadge(discount: controller.data.itemDiscount!),
              ),
          ],
        ),
      ),
    );
  }
}
