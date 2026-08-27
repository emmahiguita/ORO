import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/favourites/favouritesController.dart';
import 'package:oro/controller/items/itemsController.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/core/design/oro_pressable.dart';
import 'package:oro/core/functions/databasetranslation.dart';
import 'package:oro/view/widgets/common/oro_discount_badge.dart';
import 'package:oro/view/widgets/common/oro_product_image.dart';
import 'package:oro/data/model/itemsmodel.dart';

class CustomItemsList extends GetView<ItemscontrollerImp> {
  final ItemsModel itemsModel;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;
  final bool loading;

  const CustomItemsList({
    super.key,
    required this.itemsModel,
    this.onTap,
    this.onAddToCart,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isDiscounted = (itemsModel.itemDiscount ?? 0) > 0;
    final itemId = itemsModel.itemId;
    final rating = double.tryParse('${itemsModel.itemAvgRating}') ?? 4.9;

    return OroPressable(
      onTap: onTap ??
          () => Get.find<ItemscontrollerImp>().goToItemDetails(itemsModel),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? OroColors.surfaceDark : OroColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark ? OroColors.borderDark : OroColors.borderLight,
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.04),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image Box with Gold/Dark Radial Gradient
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(19)),
                  child: Container(
                    height: 155,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: const Alignment(0, -0.2),
                        radius: 0.9,
                        colors: isDark
                            ? [
                                OroColors.surfaceDarkElevated,
                                OroColors.ink,
                              ]
                            : [
                                const Color(0xFFF9F7F3),
                                const Color(0xFFEFECE5),
                              ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Hero(
                        tag:
                            'product-${itemsModel.itemId ?? itemsModel.hashCode}',
                        child: Material(
                          type: MaterialType.transparency,
                          child: OroProductImage(
                            imageUrl: itemsModel.itemImg,
                            productName: databaseTranslation(
                              itemsModel.itemName,
                              itemsModel.itemNameAr,
                              itemsModel.itemNameEs,
                            ),
                            categoryName: itemsModel.categoryName,
                            fit: BoxFit.contain,
                            memCacheWidth: 480,
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Discount badge
                if (isDiscounted)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: OroDiscountBadge.pill(
                      percentage: (itemsModel.itemDiscount ?? 0).toDouble(),
                    ),
                  ),

                // Favorite button (Glassmorphism circle)
                Positioned(
                  top: 10,
                  right: 10,
                  child: GetBuilder<FavouritesControllerImp>(
                    builder: (controller) => Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(18),
                        onTap: () {
                          if (itemId == null) return;
                          if (controller.favourites[itemId] == 1) {
                            controller.setFavourites(itemId, 0);
                            controller.deleteFavourites(itemId.toString());
                          } else {
                            controller.setFavourites(itemId, 1);
                            controller.addFavourites(itemId.toString());
                          }
                        },
                        child: Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (isDark ? Colors.black : Colors.white)
                                .withValues(alpha: 0.65),
                            border: Border.all(
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.12)
                                  : Colors.black.withValues(alpha: 0.08),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.15),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: Icon(
                                controller.favourites[itemId] == 1
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                key: ValueKey(controller.favourites[itemId]),
                                color: controller.favourites[itemId] == 1
                                    ? const Color(0xFFE53935)
                                    : (isDark
                                        ? const Color(0xFFCCCCCC)
                                        : const Color(0xFF666666)),
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Card Body
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category tag
                  if (itemsModel.categoryName != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        (itemsModel.categoryName ?? '').toUpperCase(),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.0,
                          color: OroColors.accentGold,
                        ),
                      ),
                    ),

                  // Title
                  Text(
                    databaseTranslation(
                      itemsModel.itemName,
                      itemsModel.itemNameAr,
                      itemsModel.itemNameEs,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      height: 1.25,
                      letterSpacing: -0.2,
                      color: isDark ? Colors.white : const Color(0xFF1E1E24),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Rating row
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFFFB300),
                        size: 15,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Color(0xFFFFB300),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Price and Cart button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "\$${(itemsModel.itemFinalPrice ?? itemsModel.itemPrice ?? 0.0).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w900,
                                color: isDark
                                    ? const Color(0xFFE2B85E)
                                    : const Color(0xFFB8860B),
                                letterSpacing: -0.4,
                              ),
                            ),
                            if (isDiscounted && itemsModel.itemPrice != null)
                              Text(
                                "\$${itemsModel.itemPrice?.toStringAsFixed(2)}",
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 11.5,
                                  color: isDark
                                      ? const Color(0xFF70707C)
                                      : const Color(0xFF999999),
                                ),
                              ),
                          ],
                        ),
                      ),

                      // Add to Cart Button (ORO Gold pill button)
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: onAddToCart,
                          child: Container(
                            height: 38,
                            width: 38,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFD4AF37),
                                  Color(0xFFA87928),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFD4AF37)
                                      .withValues(alpha: 0.35),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: loading
                                  ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.black),
                                      ),
                                    )
                                  : const Icon(
                                      Icons.add_shopping_cart_rounded,
                                      size: 18,
                                      color: Colors.black,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
