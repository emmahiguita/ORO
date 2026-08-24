import 'package:flutter/material.dart';
import 'package:oro/controller/items/itemsdetailsController.dart';
import 'package:oro/view/widgets/items/finalpricetag.dart';
import 'package:oro/view/widgets/items/originalpricetag.dart';

class PriceTags extends StatelessWidget {
  final ItemsDetailsControllerImp controller;

  const PriceTags({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (controller.data.itemDiscount! > 0)
          OriginalPriceTag(price: controller.data.itemPrice!),
        FinalPriceTag(price: controller.data.itemFinalPrice!),
      ],
    );
  }
}
