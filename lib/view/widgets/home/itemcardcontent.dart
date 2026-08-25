import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/home/homeController.dart';
import 'package:oro/core/functions/databasetranslation.dart';
import 'package:oro/data/model/itemsmodel.dart';
import 'package:oro/view/widgets/common/oro_product_image.dart';
import 'package:oro/view/widgets/common/oro_discount_badge.dart';
import 'package:oro/view/widgets/home/pricesection.dart';

class ItemCardContent extends StatelessWidget {
  final ItemsModel itemsModel;
  final int colorIndex;
  final double discountPercentage;

  const ItemCardContent({
    super.key,
    required this.itemsModel,
    required this.colorIndex,
    required this.discountPercentage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = Get.find<HomeControllerImp>().gradientColors[colorIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    accent.withValues(alpha: .11),
                    theme.colorScheme.surface,
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 140,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Hero(
                  tag: 'product-${itemsModel.itemId ?? itemsModel.hashCode}',
                  child: Material(
                    type: MaterialType.transparency,
                    child: OroProductImage(
                      imageUrl: itemsModel.itemImg,
                      productName: databaseTranslation(
                        itemsModel.itemName,
                        itemsModel.itemNameAr,
                        itemsModel.itemNameEs,
                      ),
                      categoryName: itemsModel.categoryName,
                      fit: BoxFit.contain,
                      memCacheWidth: 560,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
            if (discountPercentage > 0)
              Positioned(
                top: 12,
                left: 12,
                child: OroDiscountBadge.compact(
                  percentage: discountPercentage,
                ),
              ),
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface.withValues(alpha: .86),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.colorScheme.onSurface.withValues(alpha: .06),
                  ),
                ),
                child: const Icon(Icons.arrow_outward_rounded, size: 17),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                databaseTranslation(
                  itemsModel.itemName,
                  itemsModel.itemNameAr,
                  itemsModel.itemNameEs,
                ),
                style: theme.textTheme.titleMedium?.copyWith(
                  height: 1.2,
                  letterSpacing: -.15,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
              PriceSection(itemsModel: itemsModel, colorIndex: colorIndex),
            ],
          ),
        ),
      ],
    );
  }
}
