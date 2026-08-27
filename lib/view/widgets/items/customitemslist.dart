import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/items/itemsController.dart';
import 'package:oro/data/model/itemsmodel.dart';
import 'package:oro/view/widgets/common/oro_product_card.dart';

/// Adaptador de lista para ItemsController delegando en la tarjeta canónica OroProductCard
class CustomItemsList extends GetView<ItemscontrollerImp> {
  final ItemsModel itemsModel;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;
  final bool loading;
  final int colorIndex;
  final String? heroTag;

  const CustomItemsList({
    super.key,
    required this.itemsModel,
    required this.onTap,
    required this.loading,
    this.onAddToCart,
    this.colorIndex = 0,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return OroProductCard(
      itemsModel: itemsModel,
      onTap: () {
        if (onTap != null) {
          onTap!();
        } else {
          controller.goToItemDetails(itemsModel);
        }
      },
      onAddToCart: onAddToCart,
      loading: loading,
      colorIndex: colorIndex,
      heroTag: heroTag,
      enableInteractive360: true,
    );
  }
}
