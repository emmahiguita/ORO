import 'package:flutter/material.dart';
import 'package:oro/data/model/itemsmodel.dart';
import 'package:oro/view/widgets/home/originalprice.dart';

class PriceSection extends StatelessWidget {
  final ItemsModel itemsModel;
  final int colorIndex;

  const PriceSection({
    super.key,
    required this.itemsModel,
    required this.colorIndex,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final original = itemsModel.itemPrice?.toString() ?? '0';
    final finalPrice = itemsModel.itemFinalPrice?.toString() ?? original;

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      runSpacing: 4,
      children: [
        Text(
          '\$$finalPrice',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -.4,
          ),
        ),
        if (original != finalPrice) OriginalPrice(price: original),
      ],
    );
  }
}
