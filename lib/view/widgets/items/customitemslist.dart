import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:oro/apilink.dart';
import 'package:oro/controller/favourites/favouritesController.dart';
import 'package:oro/controller/items/itemsController.dart';
import 'package:oro/core/constant/color.dart';
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
    final isDiscounted = itemsModel.itemDiscount! > 0;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Get.find<ItemscontrollerImp>().goToItemDetails(itemsModel);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Hero(
                    tag: itemsModel.itemId!,
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(20)),
                      child: Container(
                        height: 160,
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.grey[50]!,
                              Colors.grey[100]!,
                            ],
                          ),
                        ),
                        child: OroProductImage(
                          imageUrl: itemsModel.itemImg,
                          productName: databaseTranslation(
                            itemsModel.itemName!,
                            itemsModel.itemNameAr!,
                            itemsModel.itemNameEs!,
                          ),
                          categoryName: itemsModel.categoryName,
                          fit: BoxFit.contain,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  if (isDiscounted)
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.red[400]!,
                              Colors.red[600]!,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withValues(alpha: 0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          '${itemsModel.itemDiscount}% OFF',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5),
                        ),
                      ),
                    ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: GetBuilder<FavouritesControllerImp>(
                      builder: (controller) => Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
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
                              if (controller.favourites[itemsModel.itemId] ==
                                  1) {
                                controller.setFavourites(itemsModel.itemId!, 0);
                                controller.deleteFavourites(
                                    itemsModel.itemId!.toString());
                              } else {
                                controller.setFavourites(itemsModel.itemId!, 1);
                                controller.addFavourites(
                                    itemsModel.itemId!.toString());
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child: Icon(
                                  controller.favourites[itemsModel.itemId] == 1
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  key: ValueKey(
                                      controller.favourites[itemsModel.itemId]),
                                  color: controller
                                              .favourites[itemsModel.itemId] ==
                                          1
                                      ? Appcolor.deepPink
                                      : Colors.grey[400],
                                  size: 20,
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
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      databaseTranslation(itemsModel.itemName!,
                          itemsModel.itemNameAr!, itemsModel.itemNameEs!),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                            color: Colors.grey[800],
                          ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.amber.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RatingBarIndicator(
                            rating: double.tryParse('${itemsModel.itemAvgRating}') ?? 4.8,
                            itemBuilder: (context, index) =>
                                const Icon(Icons.star, color: Colors.amber),
                            itemCount: 5,
                            itemSize: 14.0,
                            direction: Axis.horizontal,
                            unratedColor: Colors.grey[300],
                          ),
                          const SizedBox(width: 6),
                          Text(
                            (double.tryParse('${itemsModel.itemAvgRating}') ?? 4.8)
                                .toStringAsFixed(1),
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[700],
                                    ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "\$${itemsModel.itemFinalPrice?.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontFamily: "Sw",
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: isDiscounted
                                      ? Appcolor.deepPurple
                                      : Appcolor.deepPink,
                                ),
                              ),
                              if (isDiscounted)
                                Text(
                                  "\$${itemsModel.itemPrice?.toInt()}",
                                  style: TextStyle(
                                    fontFamily: "Sw",
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 13,
                                    color: Colors.grey[500],
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
                                color:
                                    Appcolor.deepPurple.withValues(alpha: 0.3),
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
                              child: Container(
                                height: 40,
                                width: 40,
                                alignment: Alignment.center,
                                child: loading
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.white),
                                        ),
                                      )
                                    : const Icon(
                                        Icons.add_shopping_cart_rounded,
                                        size: 20,
                                        color: Colors.white,
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
      ),
    );
  }
}
