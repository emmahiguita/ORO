import 'package:flutter/material.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/view/widgets/common/oro_product_image.dart';

class CartItem extends StatelessWidget {
  final String img;
  final String itemName;
  final String itemCategory;
  final String itemPrice;
  final String itemCount;
  final Function()? onAdd;
  final Function()? onRemove;
  const CartItem(
      {super.key,
      required this.img,
      required this.itemName,
      required this.itemCategory,
      required this.itemPrice,
      required this.itemCount,
      required this.onAdd,
      required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 5, right: 5),
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                color: Appcolor.whitePink,
                borderRadius: BorderRadius.circular(16),
              ),
              child: OroProductImage(
                imageUrl: img,
                productName: itemName,
                categoryName: itemCategory,
                fit: BoxFit.contain,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              itemName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              itemCategory,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              itemPrice,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Appcolor.berry,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 5, left: 5),
                            decoration: BoxDecoration(
                              color: Appcolor.lightPink,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(5),
                                splashColor:
                                    Appcolor.pink.withValues(alpha: 0.1),
                                onTap: onAdd,
                                child: const Icon(
                                  Icons.add_rounded,
                                  color: Appcolor.berry,
                                ),
                              ),
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(
                                  right: 5, left: 5, bottom: 2),
                              decoration: const BoxDecoration(),
                              child: Text(
                                itemCount,
                                style: const TextStyle(
                                    fontFamily: "Sw",
                                    fontWeight: FontWeight.bold,
                                    color: Appcolor.berry),
                              )),
                          Container(
                            margin: const EdgeInsets.only(right: 5, left: 5),
                            decoration: BoxDecoration(
                              color: Appcolor.lightPink,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(5),
                                splashColor:
                                    Appcolor.pink.withValues(alpha: 0.1),
                                onTap: onRemove,
                                child: const Icon(Icons.remove_rounded,
                                    color: Appcolor.berry),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 3),
        const Divider(
          endIndent: 20,
          indent: 20,
        ),
      ],
    );
  }
}
