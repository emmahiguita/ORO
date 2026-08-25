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
    final controller = Get.find<ItemscontrollerImp>();
    final FavouritesControllerImp favouritesController =
        Get.isRegistered<FavouritesControllerImp>()
            ? Get.find<FavouritesControllerImp>()
            : Get.put(FavouritesControllerImp());

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: Column(
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
        ),
      ),
    );
  }
}
