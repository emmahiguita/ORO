import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:oro/controller/favourites/favouritesController.dart';
import 'package:oro/controller/items/itemsController.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/design/oro_pressable.dart';
import 'package:oro/core/functions/databasetranslation.dart';
import 'package:oro/view/widgets/common/oro_product_image.dart';
import 'package:oro/data/model/itemsmodel.dart';

class CustomItemsList extends GetView<ItemscontrollerImp> {
  final ItemsModel itemsModel;
  final Function()? onTap;
  final bool loading;
  const CustomItemsList({
    super.key,
    required this.itemsModel,
    required this.onTap,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isDiscounted = (itemsModel.itemDiscount ?? 0) > 0;
    final itemId = itemsModel.itemId;

    return OroPressable(
      onTap: () {
        if (onTap != null) {
          onTap!();
        } else {
          Get.find<ItemscontrollerImp>().goToItemDetails(itemsModel);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: theme.colorScheme.onSurface.withValues(alpha: isDark ? 0.12 : 0.06),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.05),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Hero(
                  tag: 'product-${itemsModel.itemId ?? itemsModel.hashCode}',
                  child: Material(
                    type: MaterialType.transparency,
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(22)),
                      child: Container(
                        height: 155,
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              isDark
                                  ? Colors.white.withValues(alpha: 0.04)
                                  : Colors.grey.withValues(alpha: 0.06),
                              isDark
                                  ? Colors.white.withValues(alpha: 0.01)
                                  : Colors.grey.withValues(alpha: 0.02),
                            ],
                          ),
                        ),
                        child: OroProductImage(
                          imageUrl: itemsModel.itemImg,
                          productName: databaseTranslation(
                            itemsModel.itemName,
                            itemsModel.itemNameAr,
                            itemsModel.itemNameEs,
                          ),
                          categoryName: itemsModel.categoryName,
                          fit: BoxFit.contain,
                          memCacheWidth: 560,
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ),
                if (isDiscounted)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFE53935), Color(0xFFD32F2F)],
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withValues(alpha: 0.35),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        '${itemsModel.itemDiscount}% OFF',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GetBuilder<FavouritesControllerImp>(
                    builder: (controller) => Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface.withValues(alpha: 0.92),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.08),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(25),
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
                          child: Padding(
                            padding: const EdgeInsets.all(7),
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 250),
                              child: Icon(
                                controller.favourites[itemId] == 1
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                key: ValueKey(controller.favourites[itemId]),
                                color: controller.favourites[itemId] == 1
                                    ? Appcolor.deepPink
                                    : (isDark
                                        ? Colors.grey[400]
                                        : Colors.grey[500]),
                                size: 19,
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
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    databaseTranslation(itemsModel.itemName,
                        itemsModel.itemNameAr, itemsModel.itemNameEs),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      height: 1.25,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.amber.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RatingBarIndicator(
                          rating: double.tryParse(
                                  '${itemsModel.itemAvgRating}') ??
                              4.8,
                          itemBuilder: (context, index) =>
                              const Icon(Icons.star_rounded, color: Colors.amber),
                          itemCount: 5,
                          itemSize: 13.0,
                          direction: Axis.horizontal,
                          unratedColor: isDark
                              ? Colors.grey[700]
                              : Colors.grey[300],
                        ),
                        const SizedBox(width: 5),
                        Text(
                          (double.tryParse('${itemsModel.itemAvgRating}') ?? 4.8)
                              .toStringAsFixed(1),
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Colors.amber[800],
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
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
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: isDiscounted
                                    ? Appcolor.deepPurple
                                    : (isDark
                                        ? Appcolor.rosePompadour
                                        : Appcolor.deepPink),
                                letterSpacing: -0.3,
                              ),
                            ),
                            if (isDiscounted && itemsModel.itemPrice != null)
                              Text(
                                "\$${itemsModel.itemPrice?.toStringAsFixed(2)}",
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 12,
                                  color: isDark
                                      ? Colors.grey[500]
                                      : Colors.grey[500],
                                ),
                              ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Appcolor.deepPurple,
                              Appcolor.rosePompadour,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Appcolor.deepPurple.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: onTap,
                            child: SizedBox(
                              height: 38,
                              width: 38,
                              child: Center(
                                child: loading
                                    ? const SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.white),
                                        ),
                                      )
                                    : const Icon(
                                        Icons.add_shopping_cart_rounded,
                                        size: 18,
                                        color: Colors.white,
                                      ),
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
