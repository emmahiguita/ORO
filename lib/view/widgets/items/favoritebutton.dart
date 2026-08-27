import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/favourites/favouritesController.dart';
import 'package:oro/controller/items/itemsdetailsController.dart';

class FavoriteButton extends StatelessWidget {
  final ItemsDetailsControllerImp controller;

  const FavoriteButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GetBuilder<FavouritesControllerImp>(
      init: Get.isRegistered<FavouritesControllerImp>()
          ? Get.find<FavouritesControllerImp>()
          : Get.put(FavouritesControllerImp()),
      builder: (favController) {
        final itemId = controller.data.itemId;
        final isFav = itemId != null && favController.favourites[itemId] == 1;

        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            child: InkWell(
              borderRadius: BorderRadius.circular(25),
              onTap: () {
                if (itemId == null) return;
                if (isFav) {
                  favController.setFavourites(itemId, 0);
                  favController.deleteFavourites(itemId.toString());
                } else {
                  favController.setFavourites(itemId, 1);
                  favController.addFavourites(itemId.toString());
                }
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    isFav
                        ? Icons.favorite_rounded
                        : Icons.favorite_outline_rounded,
                    key: ValueKey(isFav),
                    color: isFav
                        ? theme.colorScheme.error
                        : theme.colorScheme.onSurface
                            .withValues(alpha: isDark ? .72 : .62),
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
