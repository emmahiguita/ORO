import 'package:flutter/material.dart';
import 'package:oro/core/functions/databasetranslation.dart';
import 'package:oro/data/model/categoriesmodel.dart';
import 'package:oro/data/model/itemsmodel.dart';
import 'package:oro/view/widgets/home/itemcard.dart';

class ProductSectionRail extends StatelessWidget {
  const ProductSectionRail({
    super.key,
    required this.category,
    required this.products,
    required this.onShowAll,
    required this.onProductTap,
  });

  final CategoriesModel category;
  final List<ItemsModel> products;
  final VoidCallback onShowAll;
  final ValueChanged<ItemsModel> onProductTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final categoryName = databaseTranslation(
      category.categoryName,
      category.categoryNameAr,
      category.categoryNameEs,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  categoryName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: -.45,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: onShowAll,
                iconAlignment: IconAlignment.end,
                icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                label: const Text('Ver todo'),
                style: TextButton.styleFrom(
                  foregroundColor: theme.colorScheme.primary,
                  textStyle: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 216,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: products.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final product = products[index];
              return SizedBox(
                width: 168,
                child: ItemCard(
                  itemsModel: product,
                  onTap: () => onProductTap(product),
                  colorIndex: index,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
