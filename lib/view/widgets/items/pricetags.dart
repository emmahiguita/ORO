import 'package:flutter/material.dart';
import 'package:oro/controller/items/itemsdetailsController.dart';
import 'package:oro/view/widgets/items/finalpricetag.dart';
import 'package:oro/view/widgets/items/originalpricetag.dart';

class PriceTags extends StatelessWidget {
  final ItemsDetailsControllerImp controller;

  const PriceTags({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final discount = controller.data.itemDiscount ?? 0;
    final price = controller.data.itemPrice ?? 0.0;
    final finalPrice = controller.data.itemFinalPrice ?? price;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (discount > 0 && price > finalPrice)
          OriginalPriceTag(price: price),
        FinalPriceTag(price: finalPrice),
      ],
    );
  }
}
