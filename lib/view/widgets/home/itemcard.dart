import 'package:flutter/material.dart';
import 'package:oro/core/design/oro_motion.dart';
import 'package:oro/data/model/itemsmodel.dart';
import 'package:oro/view/widgets/home/itemcardcontent.dart';

class ItemCard extends StatelessWidget {
  final ItemsModel itemsModel;
  final VoidCallback onTap;
  final int colorIndex;
  final VoidCallback? onAddToCart;

  const ItemCard({
    super.key,
    required this.itemsModel,
    required this.onTap,
    required this.colorIndex,
    this.onAddToCart,
  });

  double get discountPercentage {
    final original = itemsModel.itemPrice ?? 0;
    final current = itemsModel.itemFinalPrice ?? original;
    if (original <= 0 || current >= original) return 0;
    return ((original - current) / original) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: itemsModel.itemName ?? 'Producto ORO',
      child: Material(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(22),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () async {
            await OroMotion.selectionHaptic();
            onTap();
          },
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color:
                    Theme.of(context).colorScheme.outline.withValues(alpha: .8),
              ),
            ),
            child: ItemCardContent(
              itemsModel: itemsModel,
              colorIndex: colorIndex,
              discountPercentage: discountPercentage,
              onAddToCart: onAddToCart,
            ),
          ),
        ),
      ),
    );
  }
}
