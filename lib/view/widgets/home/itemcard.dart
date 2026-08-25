import 'package:flutter/material.dart';
import 'package:oro/core/design/oro_pressable.dart';
import 'package:oro/data/model/itemsmodel.dart';
import 'package:oro/view/widgets/home/itemcardcontent.dart';

class ItemCard extends StatelessWidget {
  final ItemsModel itemsModel;
  final VoidCallback onTap;
  final int colorIndex;

  const ItemCard({
    super.key,
    required this.itemsModel,
    required this.onTap,
    required this.colorIndex,
  });

  double get discountPercentage {
    final original =
        double.tryParse((itemsModel.itemPrice ?? '0').toString()) ?? 0;
    final finalPrice =
        double.tryParse((itemsModel.itemFinalPrice ?? '0').toString()) ?? 0;
    if (original <= 0 || finalPrice >= original) return 0;
    return ((original - finalPrice) / original) * 100;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return OroPressable(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: theme.colorScheme.onSurface.withValues(alpha: .07),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .04),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ItemCardContent(
          itemsModel: itemsModel,
          colorIndex: colorIndex,
          discountPercentage: discountPercentage,
        ),
      ),
    );
  }
}
