import 'package:flutter/material.dart';
import 'package:oro/core/design/oro_colors.dart';
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
    final accents = [
      OroColors.accentGold,
      const Color(0xFF82C7A5),
      const Color(0xFFD1AF76),
    ];
    final accent = accents[colorIndex % accents.length];

    return OroPressable(
      pressedScale: .972,
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: theme.brightness == Brightness.dark
                ? Colors.white.withValues(alpha: .20)
                : theme.colorScheme.outline.withValues(alpha: .7),
          ),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(
                alpha: theme.brightness == Brightness.dark ? .10 : .05,
              ),
              blurRadius: 26,
              spreadRadius: -8,
              offset: const Offset(0, 13),
            ),
            BoxShadow(
              color: Colors.black.withValues(
                alpha: theme.brightness == Brightness.dark ? .30 : .08,
              ),
              blurRadius: 22,
              offset: const Offset(0, 10),
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
