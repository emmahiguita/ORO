import 'package:flutter/material.dart';
import 'package:oro/core/class/handlingdataview.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/core/formatters/oro_money.dart';
import 'package:oro/core/functions/databasetranslation.dart';
import 'package:oro/view/widgets/common/oro_product_image.dart';

import '../../../controller/favourites/ViewFavouritesController.dart';

class FavouritesList extends StatelessWidget {
  final ViewFavouritesControllerImp controller;

  const FavouritesList({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return HandlingDataView(
      statusRequest: controller.statusRequest,
      widget: controller.fav.isEmpty
          ? const _EmptyFavourites()
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 110),
              itemCount: controller.fav.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final item = controller.fav[index];
                final id = item.itemId?.toString() ?? '$index';
                final price = item.itemFinalPrice ?? item.itemPrice ?? 0;
                final rating = double.tryParse('${item.itemAvgRating}') ?? 0;
                final name = databaseTranslation(
                  item.itemName,
                  item.itemNameAr,
                  item.itemNameEs,
                );

                final category = databaseTranslation(
                  item.categoryName,
                  item.categoryNameAr,
                  item.categoryNameEs,
                );

                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 180),
                  opacity: controller.isDeleting(id) ? 0 : 1,
                  child: Material(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () => controller.goToItemDetails(item),
                      child: Ink(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? OroColors.surfaceDark
                              : Theme.of(context).colorScheme.surface,
                          border: Border.all(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? OroColors.borderDark
                                    : OroColors.borderLight,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(
                                alpha: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? .18
                                    : .04,
                              ),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Hero(
                              tag:
                                  'product-fav-$index-${item.itemId ?? item.hashCode}',
                              child: Material(
                                color: Colors.transparent,
                                child: Container(
                                  width: 92,
                                  height: 92,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? OroColors.surfaceDarkElevated
                                        : const Color(0xFFF3F2EC),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? OroColors.borderDark
                                              .withValues(alpha: .5)
                                          : OroColors.borderLight
                                              .withValues(alpha: .6),
                                      width: 0.8,
                                    ),
                                  ),
                                  child: OroProductImage(
                                    imageUrl: item.itemImg,
                                    productName: name,
                                    categoryName: item.categoryName,
                                    fit: BoxFit.contain,
                                    memCacheWidth: 360,
                                    showFallbackLabel: false,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (category.trim().isNotEmpty)
                                    Text(
                                      category.toUpperCase(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? OroColors.accentGold
                                            : OroColors.forest,
                                        fontSize: 9,
                                        letterSpacing: .7,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  if (category.trim().isNotEmpty)
                                    const SizedBox(height: 3),
                                  Text(
                                    name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 13.5,
                                          height: 1.20,
                                        ),
                                  ),
                                  if (rating > 0) ...[
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star_rounded,
                                          size: 14,
                                          color: OroColors.accentGold,
                                        ),
                                        const SizedBox(width: 3),
                                        Text(
                                          rating.toStringAsFixed(1),
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall
                                              ?.copyWith(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 11,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                  const SizedBox(height: 6),
                                  Text(
                                    OroMoney.format(price),
                                    style: TextStyle(
                                      fontSize: 15.5,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: -.3,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? OroColors.textPrimaryDark
                                          : OroColors.textPrimaryLight,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              tooltip: 'Quitar de favoritos',
                              onPressed: () => controller.deleteFavourites(id),
                              style: IconButton.styleFrom(
                                minimumSize: const Size(44, 44),
                                backgroundColor:
                                    OroColors.error.withValues(alpha: .08),
                                foregroundColor: OroColors.error,
                              ),
                              icon: const Icon(
                                Icons.favorite_rounded,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class _EmptyFavourites extends StatelessWidget {
  const _EmptyFavourites();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: const BoxDecoration(
                color: OroColors.forestSoft,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_border_rounded,
                color: OroColors.forest,
                size: 38,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Guarda lo que te gusta',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tus favoritos aparecerán aquí para que puedas volver a ellos rápidamente.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: .58),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
