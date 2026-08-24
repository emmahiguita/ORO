import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/favourites/favouritesController.dart';
import 'package:oro/controller/items/itemsController.dart';
import 'package:oro/view/widgets/items/CategorieslistItems.dart';
import 'package:oro/view/widgets/items/categorypagecontent.dart';

class ItemsView extends StatelessWidget {
  const ItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ItemscontrollerImp());
    FavouritesControllerImp favouritesController =
        Get.put(FavouritesControllerImp());

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        bottom: false,
        child: GetBuilder<ItemscontrollerImp>(
          builder: (controller) {
            return Column(
              children: [
                const SizedBox(height: 8),
                const CategorieslistItems(),
              Expanded(
                child: PageView.builder(
                  controller: controller.pageController,
                  onPageChanged: (index) {
                    controller.onPageChanged(index);
                  },
                  itemCount: controller.categories.length,
                  itemBuilder: (context, pageIndex) {
                    return CategoryPageContent(
                      categoryIndex: pageIndex,
                      favouritesController: favouritesController,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
  }
}
