import 'package:flutter/material.dart';
import 'package:oro/core/design/oro_colors.dart';
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
    final isDark = theme.brightness == Brightness.dark;

    final categoryName = databaseTranslation(
      category.categoryName,
      category.categoryNameAr,
      category.categoryNameEs,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Encabezado compacto de sección
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 14,
                decoration: BoxDecoration(
                  color: OroColors.accentGold,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  categoryName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    color: Colors.white,
                    letterSpacing: -0.3,
                  ),
                ),
              ),
              InkWell(
                onTap: onShowAll,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Ver todo',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? OroColors.accentGold
                              : OroColors.forest,
                        ),
                      ),
                      const SizedBox(width: 3),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 11,
                        color: isDark
                            ? OroColors.accentGold
                            : OroColors.forest,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        // Carrusel horizontal de tarjetas compactas (Visibilidad 100% de productos)
        SizedBox(
          height: 258,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: products.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final product = products[index];
              return SizedBox(
                width: 156,
                child: ItemCard(
                  itemsModel: product,
                  onTap: () => onProductTap(product),
                  colorIndex: index,
                  heroTag:
                      'product-rail-${category.categoryId}-$index-${product.itemId ?? product.hashCode}',
                  enableInteractive360: true,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
