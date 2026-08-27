import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:oro/controller/favourites/favouritesController.dart';
import 'package:oro/controller/items/itemsController.dart';
import 'package:oro/core/design/oro_breakpoints.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/view/widgets/items/customitemslist.dart';

class CategoryPageContent extends GetView<ItemscontrollerImp> {
  final int categoryIndex;
  final FavouritesControllerImp favouritesController;

  const CategoryPageContent({
    super.key,
    required this.categoryIndex,
    required this.favouritesController,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ItemscontrollerImp>(
      builder: (controller) {
        if (categoryIndex >= controller.categories.length) {
          return const SizedBox.shrink();
        }
        final categoryId =
            controller.categories[categoryIndex]['category_id'].toString();
        final categoryModels = controller.getCategoryItemsModels(categoryId);
        final isLoading = controller.isCategoryLoading(categoryId);
        final isDark = Theme.of(context).brightness == Brightness.dark;

        if (isLoading) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Color(0xFFD4AF37),
                ),
                SizedBox(height: 16),
                Text(
                  'Preparando la colección...',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: OroColors.accentGold,
                  ),
                ),
              ],
            ),
          );
        }

        if (categoryModels.isEmpty) {
          return RefreshIndicator(
            onRefresh: () => controller.refreshCategory(categoryId),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                Center(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: isDark
                              ? OroColors.surfaceDarkElevated
                              : OroColors.surface,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.shopping_bag_outlined,
                          size: 64,
                          color: isDark ? Colors.grey[600] : Colors.grey[400],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'No se encontraron productos',
                        style: TextStyle(
                          color: isDark ? Colors.grey[300] : Colors.grey[700],
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Desliza hacia abajo para actualizar el catálogo',
                        style: TextStyle(
                          color: isDark ? Colors.grey[500] : Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            final columns = OroBreakpoints.gridColumns(constraints.maxWidth);

            return RefreshIndicator(
              onRefresh: () => controller.refreshCategory(categoryId),
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                      child: Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: OroColors.accentGold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${categoryModels.length} piezas seleccionadas',
                            style: TextStyle(
                              color: isDark
                                  ? const Color(0xFF9E9EA8)
                                  : Colors.grey[700],
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 90),
                    sliver: SliverMasonryGrid.count(
                      crossAxisCount: columns,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      itemBuilder: (context, index) {
                        final item = categoryModels[index];
                        return CustomItemsList(
                          loading: controller.isLoadingItem(item.itemId ?? -1),
                          onAddToCart: () {
                            if (item.itemId != null) {
                              controller.addToCart("${item.itemId}");
                            }
                          },
                          onTap: () {
                            controller.goToItemDetails(item);
                          },
                          itemsModel: item,
                        );
                      },
                      childCount: categoryModels.length,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
