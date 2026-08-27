import 'package:flutter/material.dart';
import 'package:oro/data/model/itemsmodel.dart';
import 'package:oro/view/widgets/common/oro_product_card.dart';

/// Adaptador de ItemCard para Home y Secciones, delegando a OroProductCard
class ItemCard extends StatelessWidget {
  final ItemsModel itemsModel;
  final VoidCallback onTap;
  final int colorIndex;
  final VoidCallback? onAddToCart;
  final String? heroTag;
  final bool enableInteractive360;

  const ItemCard({
    super.key,
    required this.itemsModel,
    required this.onTap,
    required this.colorIndex,
    this.onAddToCart,
    this.heroTag,
    this.enableInteractive360 = true,
  });

  @override
  Widget build(BuildContext context) {
    return OroProductCard(
      itemsModel: itemsModel,
      onTap: onTap,
      onAddToCart: onAddToCart,
      colorIndex: colorIndex,
      heroTag: heroTag,
      enableInteractive360: enableInteractive360,
    );
  }
}
