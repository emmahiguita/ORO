import 'package:flutter/material.dart';
import 'package:oro/controller/items/itemsdetailsController.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/core/functions/databasetranslation.dart';
import 'package:oro/view/widgets/common/oro_product_image.dart';
import 'package:oro/view/widgets/common/oro_discount_badge.dart';
import 'package:oro/view/widgets/items/pricetags.dart';

class ProductImageSection extends StatelessWidget {
  final ItemsDetailsControllerImp controller;

  const ProductImageSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final width = MediaQuery.of(context).size.width;
    final imageHeight = (width * 0.75).clamp(260.0, 420.0);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            isDark ? OroColors.surfaceDarkElevated : const Color(0xFFEBE6DC),
            Theme.of(context).scaffoldBackgroundColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.85],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: imageHeight,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      gradient: RadialGradient(
                        center: const Alignment(0, -0.15),
                        radius: 1.05,
                        colors: [
                          isDark
                              ? OroColors.surfaceDarkElevated
                              : const Color(0xFFF1EBDD),
                          isDark ? OroColors.ink : Colors.white,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withValues(alpha: isDark ? .25 : .08),
                          blurRadius: 28,
                          offset: const Offset(0, 14),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Hero(
                          tag:
                              'product-${controller.data.itemId ?? controller.data.hashCode}',
                          child: Material(
                            type: MaterialType.transparency,
                            child: OroProductImage(
                              imageUrl: controller.data.itemImg,
                              productName: databaseTranslation(
                                controller.data.itemName,
                                controller.data.itemNameAr,
                                controller.data.itemNameEs,
                              ),
                              categoryName: controller.data.categoryName,
                              fit: BoxFit.contain,
                              height: imageHeight * 0.82,
                              memCacheWidth: 1080,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if ((controller.data.itemDiscount ?? 0) > 0)
                    Positioned(
                      top: 14,
                      left: 14,
                      child: OroDiscountBadge.pill(
                        percentage:
                            (controller.data.itemDiscount ?? 0).toDouble(),
                      ),
                    ),
                  Positioned(
                    bottom: 14,
                    right: 14,
                    child: PriceTags(controller: controller),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
