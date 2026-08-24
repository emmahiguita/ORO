import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oro/apilink.dart';
import 'package:oro/core/class/handlingdataview.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/functions/databasetranslation.dart';
import 'package:oro/view/widgets/common/oro_product_image.dart';

import '../../../controller/favourites/ViewFavouritesController.dart';

class FavouritesList extends StatelessWidget {
  final ViewFavouritesControllerImp controller;
  const FavouritesList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return HandlingDataView(
        statusRequest: controller.statusRequest,
        widget: controller.fav.isEmpty
            ? Container(
                margin: const EdgeInsets.only(top: 80),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.favorite_border_rounded,
                      size: 64,
                      color: Appcolor.berry.withValues(alpha: 0.4),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Tu lista de favoritos está vacía",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Appcolor.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Guarda los artículos que más te gusten para verlos y comprarlos luego.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: controller.fav.length,
                itemBuilder: (context, index) {
                  final itemId = controller.fav[index].itemId.toString();
                  final isDeleting = controller.isDeleting(itemId);
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: isDeleting
                        ? const SizedBox.shrink()
                        : Column(
                            key: ValueKey(itemId),
                            children: [
                              const Divider(endIndent: 20, indent: 20),
                              const SizedBox(height: 10),
                              AnimatedOpacity(
                                opacity: isDeleting ? 0 : 1,
                                duration: const Duration(milliseconds: 250),
                                child: Material(
                                  color: Appcolor
                                      .white, // Match your container background
                                  child: InkWell(
                                    splashColor: Colors.pink.withValues(
                                        alpha: 0.2), // Customize as needed
                                    onTap: () {
                                      controller.goToItemDetails(
                                          controller.fav[index]);
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 10,
                                                      bottom: 40,
                                                      right: 4),
                                                  child: Text(
                                                      (index + 1).toString(),
                                                      style: const TextStyle(
                                                          color: Appcolor.black,
                                                          fontFamily: 'Sw',
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 10),
                                                  height: 92,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    color: Appcolor.mimiPink,
                                                    borderRadius:
                                                        BorderRadius.circular(8),
                                                  ),
                                                  child: Center(
                                                    child: Hero(
                                                      tag: controller
                                                          .fav[index].itemId!,
                                                      child: OroProductImage(
                                                        imageUrl: controller
                                                            .fav[index].itemImg,
                                                        productName: databaseTranslation(
                                                          controller.fav[index].itemName,
                                                          controller.fav[index].itemNameAr,
                                                          controller.fav[index].itemNameEs,
                                                        ),
                                                        categoryName: controller
                                                            .fav[index].categoryName,
                                                        fit: BoxFit.contain,
                                                        borderRadius: BorderRadius.circular(8),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        databaseTranslation(
                                                          controller.fav[index].itemName,
                                                          controller.fav[index].itemNameAr,
                                                          controller.fav[index].itemNameEs,
                                                        ),
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: const TextStyle(
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        "\$${(controller.fav[index].itemFinalPrice ?? controller.fav[index].itemPrice ?? 0.0).toStringAsFixed(2)}",
                                                        style: const TextStyle(
                                                          fontFamily: "Sw",
                                                          fontWeight: FontWeight.bold,
                                                          color: Appcolor.deepPurple,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 2),
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.star_rounded,
                                                            color: Colors.amber,
                                                            size: 16,
                                                          ),
                                                          const SizedBox(width: 2),
                                                          Text(
                                                            (double.tryParse('${controller.fav[index].itemAvgRating}') ?? 4.8)
                                                                .toStringAsFixed(1),
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.w600,
                                                              color: Colors.grey[700],
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
                                          InkWell(
                                            onTap: () {
                                              controller
                                                  .deleteFavourites(itemId);
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  right: 5),
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                color: Appcolor.pink,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: const Icon(
                                                Icons.remove,
                                                size: 29,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Divider(endIndent: 20, indent: 20),
                            ],
                          ),
                  );
                },
              ));
  }
}
