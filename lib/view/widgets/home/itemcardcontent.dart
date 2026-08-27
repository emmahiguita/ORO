import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/cart/cartController.dart';
import 'package:oro/controller/favourites/favouritesController.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/core/formatters/oro_money.dart';
import 'package:oro/core/functions/databasetranslation.dart';
import 'package:oro/data/model/itemsmodel.dart';
import 'package:oro/view/widgets/common/oro_product_image.dart';

class ItemCardContent extends StatelessWidget {
  final ItemsModel itemsModel;
  final int colorIndex;
  final double discountPercentage;
  final VoidCallback? onAddToCart;

  const ItemCardContent({
    super.key,
    required this.itemsModel,
    required this.colorIndex,
    required this.discountPercentage,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final productName = databaseTranslation(
      itemsModel.itemName,
      itemsModel.itemNameAr,
      itemsModel.itemNameEs,
    );
    final category = databaseTranslation(
      itemsModel.categoryName,
      itemsModel.categoryNameAr,
      itemsModel.categoryNameEs,
    );
    final currentPrice = itemsModel.itemFinalPrice ?? itemsModel.itemPrice ?? 0;
    final originalPrice = itemsModel.itemPrice ?? currentPrice;
    final rating = double.tryParse('${itemsModel.itemAvgRating}') ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                color: theme.brightness == Brightness.dark
                    ? OroColors.surfaceDarkElevated
                    : const Color(0xFFF2F1EC),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Hero(
                  tag: 'product-${itemsModel.itemId ?? itemsModel.hashCode}',
                  child: Material(
                    color: Colors.transparent,
                    child: OroProductImage(
                      imageUrl: itemsModel.itemImg,
                      productName: productName,
                      categoryName: itemsModel.categoryName,
                      fit: BoxFit.contain,
                      memCacheWidth: 560,
                      showFallbackLabel: false,
                    ),
                  ),
                ),
              ),
              if (discountPercentage > 0)
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: OroColors.ink.withValues(alpha: .90),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      '-${discountPercentage.round()}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              Positioned(
                top: 8,
                right: 8,
                child: _FavouriteAction(itemId: itemsModel.itemId),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (category.trim().isNotEmpty)
                Text(
                  category.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: OroColors.forest,
                    fontSize: 9,
                    letterSpacing: .7,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              if (category.trim().isNotEmpty) const SizedBox(height: 5),
              Text(
                productName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  height: 1.18,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  if (rating > 0) ...[
                    const Icon(
                      Icons.star_rounded,
                      size: 14,
                      color: OroColors.accentGold,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      rating.toStringAsFixed(1),
                      style: theme.textTheme.labelSmall,
                    ),
                    const SizedBox(width: 8),
                  ],
                  Expanded(
                    child: Text(
                      OroMoney.format(currentPrice),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  _CartAction(
                    itemId: itemsModel.itemId,
                    onAddToCart: onAddToCart,
                  ),
                ],
              ),
              if (discountPercentage > 0) ...[
                const SizedBox(height: 2),
                Text(
                  OroMoney.format(originalPrice),
                  style: theme.textTheme.labelSmall?.copyWith(
                    decoration: TextDecoration.lineThrough,
                    color: theme.colorScheme.onSurface.withValues(alpha: .42),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _FavouriteAction extends StatelessWidget {
  const _FavouriteAction({required this.itemId});
  final int? itemId;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavouritesControllerImp>(
      init: Get.isRegistered<FavouritesControllerImp>()
          ? Get.find<FavouritesControllerImp>()
          : Get.put(FavouritesControllerImp()),
      builder: (controller) {
        final active = itemId != null && controller.favourites[itemId] == 1;
        return _RoundAction(
          icon: active ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          color: active
              ? OroColors.error
              : Theme.of(context).colorScheme.onSurface,
          onTap: itemId == null
              ? null
              : () {
                  controller.setFavourites(itemId!, active ? 0 : 1);
                  if (active) {
                    controller.deleteFavourites('$itemId');
                  } else {
                    controller.addFavourites('$itemId');
                  }
                },
        );
      },
    );
  }
}

class _CartAction extends StatelessWidget {
  const _CartAction({required this.itemId, this.onAddToCart});
  final int? itemId;
  final VoidCallback? onAddToCart;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartControllerImp>(
      init: Get.isRegistered<CartControllerImp>()
          ? Get.find<CartControllerImp>()
          : Get.put(CartControllerImp()),
      builder: (controller) {
        return _RoundAction(
          icon: Icons.add_rounded,
          color: Colors.white,
          filled: true,
          onTap: itemId == null
              ? null
              : onAddToCart ?? () => controller.addCart('$itemId'),
        );
      },
    );
  }
}

class _RoundAction extends StatelessWidget {
  const _RoundAction({
    required this.icon,
    required this.color,
    required this.onTap,
    this.filled = false,
  });

  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: filled
          ? OroColors.forest
          : Theme.of(context).colorScheme.surface.withValues(alpha: .95),
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 38,
          height: 38,
          child: Icon(icon, size: 20, color: color),
        ),
      ),
    );
  }
}
