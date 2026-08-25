import 'package:flutter/material.dart';
import 'package:oro/core/class/handlingdataview.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/design/oro_pressable.dart';
import 'package:oro/core/functions/databasetranslation.dart';
import 'package:oro/view/widgets/common/oro_product_image.dart';

import '../../../controller/favourites/ViewFavouritesController.dart';

class FavouritesList extends StatelessWidget {
  final ViewFavouritesControllerImp controller;
  const FavouritesList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return HandlingDataView(
      statusRequest: controller.statusRequest,
      widget: controller.fav.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 96,
                      width: 96,
                      decoration: BoxDecoration(
                        color: Appcolor.deepPink.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite_border_rounded,
                        size: 48,
                        color: Appcolor.deepPink,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Tu lista de favoritos está vacía",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Guarda los artículos que más te gusten para verlos y comprarlos luego.",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              itemCount: controller.fav.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = controller.fav[index];
                final itemId = item.itemId?.toString() ?? '$index';
                final isDeleting = controller.isDeleting(itemId);
                final price = item.itemFinalPrice ?? item.itemPrice ?? 0.0;
                final rating = double.tryParse('${item.itemAvgRating}') ?? 4.8;

                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: isDeleting
                      ? const SizedBox.shrink()
                      : OroPressable(
                          key: ValueKey(itemId),
                          onTap: () {
                            controller.goToItemDetails(item);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surface,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: theme.colorScheme.onSurface
                                    .withValues(alpha: isDark ? 0.12 : 0.06),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(
                                      alpha: isDark ? 0.2 : 0.04),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                Hero(
                                  tag: 'product-${item.itemId ?? item.hashCode}',
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: Container(
                                      height: 82,
                                      width: 82,
                                      decoration: BoxDecoration(
                                        color: isDark
                                            ? Colors.white.withValues(alpha: 0.05)
                                            : Appcolor.mimiPink
                                                .withValues(alpha: 0.35),
                                        borderRadius:
                                            BorderRadius.circular(14),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(14),
                                        child: OroProductImage(
                                          imageUrl: item.itemImg,
                                          productName: databaseTranslation(
                                            item.itemName,
                                            item.itemNameAr,
                                            item.itemNameEs,
                                          ),
                                          categoryName: item.categoryName,
                                          fit: BoxFit.contain,
                                          memCacheWidth: 320,
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        databaseTranslation(
                                          item.itemName,
                                          item.itemNameAr,
                                          item.itemNameEs,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: theme.textTheme.titleSmall
                                            ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          height: 1.25,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star_rounded,
                                            color: Colors.amber,
                                            size: 15,
                                          ),
                                          const SizedBox(width: 3),
                                          Text(
                                            rating.toStringAsFixed(1),
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.amber[800],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        "\$${price.toStringAsFixed(2)}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 16,
                                          color: Appcolor.deepPurple,
                                          letterSpacing: -0.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                  onPressed: () {
                                    controller.deleteFavourites(itemId);
                                  },
                                  style: IconButton.styleFrom(
                                    backgroundColor:
                                        Colors.red.withValues(alpha: 0.1),
                                    foregroundColor: Colors.red[600],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.all(8),
                                  ),
                                  icon: const Icon(
                                    Icons.delete_outline_rounded,
                                    size: 20,
                                  ),
                                ),
                              ],
                              ),
                            ),
                          ),
                );
              },
            ),
    );
  }
}
