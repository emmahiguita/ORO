import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:oro/controller/admin/items/viewitemscontroller.dart';
import 'package:oro/core/class/statusrequest.dart';
import 'package:oro/view/widgets/admin/ProductCard.dart';

class ProductsGrid extends StatelessWidget {
  final ViewItemsControllerImp controller;
  const ProductsGrid({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewItemsControllerImp>(
      builder: (controller) {
        if (controller.statusRequest == StatusRequest.loding) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.filteredItems.isEmpty) {
          return const Center(child: Text('No se encontraron productos'));
        }

        return Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
          child: MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.filteredItems.length,
            itemBuilder: (context, index) => ProductCard(
              item: controller.filteredItems[index],
              onEdit: () {
                controller.goToEditItem(controller.filteredItems[index]);
              },
              onDelete: () {
                controller.showDeleteDialog(
                  controller.filteredItems[index].itemName ?? 'Product',
                  () {
                    controller.deleteItem(
                      controller.filteredItems[index].itemId.toString(),
                      controller.filteredItems[index].itemImg!,
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
