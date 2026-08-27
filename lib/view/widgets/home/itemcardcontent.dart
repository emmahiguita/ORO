import 'package:flutter/material.dart';
import 'package:oro/data/model/itemsmodel.dart';
import 'package:oro/view/widgets/common/oro_product_card.dart';

/// Adaptador retrocompatible de ItemCardContent que delega a OroProductCard
class ItemCardContent extends StatelessWidget {
  final ItemsModel itemsModel;
  final int colorIndex;
  final double discountPercentage;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;
  final String? heroTag;
  final bool enableInteractive360;

  const ItemCardContent({
    super.key,
    required this.itemsModel,
    required this.colorIndex,
    required this.discountPercentage,
    this.onTap,
    this.onAddToCart,
    this.heroTag,
    this.enableInteractive360 = true,
  });

  @override
  Widget build(BuildContext context) {
    return OroProductCard(
      itemsModel: itemsModel,
      colorIndex: colorIndex,
      onTap: onTap,
      onAddToCart: onAddToCart,
      heroTag: heroTag,
      enableInteractive360: enableInteractive360,
    );
  }
}
