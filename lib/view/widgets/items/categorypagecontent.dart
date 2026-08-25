import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:oro/controller/favourites/favouritesController.dart';
import 'package:oro/controller/items/itemsController.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/core/design/oro_breakpoints.dart';
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

        if (isLoading) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Appcolor.berry,
                ),
                SizedBox(height: 16),
                Text(
                  'Cargando productos exclusivos...',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Appcolor.berry,
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
                          color: Colors.grey[100],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.shopping_bag_outlined,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'No se encontraron productos',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Desliza hacia abajo para actualizar el catálogo',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[500],
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
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                      child: Text(
                        '${categoryModels.length} productos disponibles',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
                    sliver: SliverMasonryGrid.count(
                      crossAxisCount: columns,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      itemBuilder: (context, index) {
                        final item = categoryModels[index];
                        return CustomItemsList(
                          loading: controller.isLoadingItem(item.itemId ?? -1),
                          onTap: () {
                            if (item.itemId != null) {
                              controller.addToCart("${item.itemId}");
                            }
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
