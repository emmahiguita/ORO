import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:oro/controller/favourites/favouritesController.dart';
import 'package:oro/controller/items/itemsController.dart';
import 'package:oro/core/constant/color.dart';
import 'package:oro/data/model/itemsmodel.dart';
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
        final categoryId =
            controller.categories[categoryIndex]['category_id'].toString();
        final categoryData = controller.getCategoryData(categoryId);
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

        if (categoryData.isEmpty) {
          return RefreshIndicator(
            onRefresh: () => controller.refreshCategory(categoryId),
            child: ListView(
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

        return RefreshIndicator(
          onRefresh: () => controller.refreshCategory(categoryId),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Container(
                  key: ValueKey(categoryData.length),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  child: Text(
                    '${categoryData.length} productos disponibles',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                itemCount: categoryData.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  favouritesController
                          .favourites[categoryData[index]["item_id"]] =
                      categoryData[index]["favourite"];
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 200 + (index * 50)),
                    curve: Curves.easeOutBack,
                    child: CustomItemsList(
                      loading: controller
                          .isLoadingItem(categoryData[index]["item_id"]),
                      onTap: () {
                        controller
                            .addToCart("${categoryData[index]["item_id"]}");
                      },
                      itemsModel: ItemsModel.fromJson(categoryData[index]),
                    ),
                  );
                },
              ),
              const SizedBox(height: 80),
            ],
          ),
        );
      },
    );
  }
}
