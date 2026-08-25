import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/favourites/favouritesController.dart';
import 'package:oro/controller/items/itemsdetailsController.dart';

class FavoriteButton extends StatelessWidget {
  final ItemsDetailsControllerImp controller;

  const FavoriteButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavouritesControllerImp>(
      builder: (favController) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
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
              final itemId = controller.data.itemId;
              if (itemId == null) return;
              if (favController.favourites[itemId] == 1) {
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
                  favController.favourites[controller.data.itemId] == 1
                      ? Icons.favorite
                      : Icons.favorite_border,
                  key: ValueKey(
                      favController.favourites[controller.data.itemId]),
                  color: favController.favourites[controller.data.itemId] == 1
                      ? Colors.red[400]
                      : Colors.grey[600],
                  size: 24,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
