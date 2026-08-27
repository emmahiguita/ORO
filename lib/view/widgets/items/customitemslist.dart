import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oro/controller/favourites/favouritesController.dart';
import 'package:oro/controller/items/itemsController.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/core/formatters/oro_money.dart';
import 'package:oro/core/functions/databasetranslation.dart';
import 'package:oro/data/model/itemsmodel.dart';
import 'package:oro/view/widgets/common/oro_product_image.dart';

class CustomItemsList extends GetView<ItemscontrollerImp> {
  final ItemsModel itemsModel;
  final Function()? onTap;
  final VoidCallback? onAddToCart;
  final bool loading;

  const CustomItemsList({
    super.key,
    required this.itemsModel,
    required this.onTap,
    required this.loading,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final name = databaseTranslation(
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
    final discount = itemsModel.itemDiscount ?? 0;
    final rating = double.tryParse('${itemsModel.itemAvgRating}') ?? 0;

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(22),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          HapticFeedback.selectionClick();
          onTap?.call() ?? controller.goToItemDetails(itemsModel);
        },
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: .78),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      color: theme.brightness == Brightness.dark
                          ? OroColors.surfaceDarkElevated
                          : const Color(0xFFF2F1EC),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Hero(
                        tag:
                            'product-${itemsModel.itemId ?? itemsModel.hashCode}',
                        child: Material(
                          color: Colors.transparent,
                          child: OroProductImage(
                            imageUrl: itemsModel.itemImg,
                            productName: name,
                            categoryName: itemsModel.categoryName,
                            fit: BoxFit.contain,
                            memCacheWidth: 640,
                            showFallbackLabel: false,
                          ),
                        ),
                      ),
                    ),
                    if (discount > 0)
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
                            '-$discount%',
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
                      child: _FavouriteButton(
                        itemId: itemsModel.itemId,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 13, 14, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (category.isNotEmpty)
                      Text(
                        category.toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: OroColors.forest,
                          fontSize: 9,
                          letterSpacing: .65,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    if (category.isNotEmpty) const SizedBox(height: 5),
                    Text(
                      name,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        height: 1.20,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (rating > 0)
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            size: 15,
                            color: OroColors.accentGold,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            rating.toStringAsFixed(1),
                            style: theme.textTheme.labelSmall,
                          ),
                        ],
                      ),
                    if (rating > 0) const SizedBox(height: 8),
                    Text(
                      OroMoney.format(currentPrice),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                        letterSpacing: -.2,
                      ),
                    ),
                    if (discount > 0) ...[
                      const SizedBox(height: 2),
                      Text(
                        OroMoney.format(originalPrice),
                        style: theme.textTheme.labelSmall?.copyWith(
                          decoration: TextDecoration.lineThrough,
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: .42),
                        ),
                      ),
                    ],
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: FilledButton.icon(
                        onPressed: loading ? null : onAddToCart ?? onTap,
                        icon: loading
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(
                                Icons.shopping_bag_outlined,
                                size: 18,
                              ),
                        label: Text(
                          loading ? 'Agregando…' : 'Agregar',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FavouriteButton extends StatelessWidget {
  const _FavouriteButton({required this.itemId});

  final int? itemId;

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<FavouritesControllerImp>()) {
      return const SizedBox.shrink();
    }

    return GetBuilder<FavouritesControllerImp>(
      builder: (controller) {
        final active = itemId != null && controller.favourites[itemId] == 1;

        return Material(
          color: Theme.of(context).colorScheme.surface.withValues(alpha: .95),
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: itemId == null
                ? null
                : () {
                    controller.setFavourites(
                      itemId!,
                      active ? 0 : 1,
                    );
                    if (active) {
                      controller.deleteFavourites('$itemId');
                    } else {
                      controller.addFavourites('$itemId');
                    }
                  },
            child: SizedBox(
              width: 42,
              height: 42,
              child: Icon(
                active ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                size: 21,
                color: active
                    ? OroColors.error
                    : Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        );
      },
    );
  }
}
