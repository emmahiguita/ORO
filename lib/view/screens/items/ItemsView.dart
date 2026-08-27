import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/controller/favourites/favouritesController.dart';
import 'package:oro/controller/items/itemsController.dart';
import 'package:oro/core/design/oro_colors.dart';
import 'package:oro/core/design/oro_motion.dart';
import 'package:oro/view/screens/search/search.dart';
import 'package:oro/view/widgets/items/CategorieslistItems.dart';
import 'package:oro/view/widgets/items/categorypagecontent.dart';

class ItemsView extends StatelessWidget {
  const ItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<ItemscontrollerImp>()
        ? Get.find<ItemscontrollerImp>()
        : Get.put(ItemscontrollerImp());
    final FavouritesControllerImp favouritesController =
        Get.isRegistered<FavouritesControllerImp>()
            ? Get.find<FavouritesControllerImp>()
            : Get.put(FavouritesControllerImp());

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: OroColors.nightBlue.withValues(alpha: 0.65),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.20),
              ),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: OroColors.crystalWhite,
              size: 18,
            ),
          ),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Catálogo Exclusivo",
          style: TextStyle(
            color: OroColors.crystalWhite,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: OroColors.nightBlue.withValues(alpha: 0.65),
                shape: BoxShape.circle,
                border: Border.all(
                  color: OroColors.accentGold.withValues(alpha: 0.40),
                ),
              ),
              child: const Icon(
                Icons.search_rounded,
                color: OroColors.accentGold,
                size: 20,
              ),
            ),
            onPressed: () {
              OroMotion.selectionHaptic();
              Get.to(() => const Search());
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Fondo Global Selva Líquida
          Positioned.fill(
            child: Image.asset(
              'assets/images/store_liquid_jungle_background.png',
              fit: BoxFit.cover,
              alignment: Alignment.center,
              errorBuilder: (_, __, ___) => Image.asset(
                'images/store_liquid_jungle_background.png',
                fit: BoxFit.cover,
                alignment: Alignment.center,
                errorBuilder: (_, __, ___) => Container(
                  color: OroColors.nightBlue,
                ),
              ),
            ),
          ),

          // 2. Capa de Protección Sutil
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: OroColors.protectionGradient,
              ),
            ),
          ),

          // 3. Contenido de Categorías y Grid de Productos Water Liquid Glass
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                const SizedBox(height: 6),
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
        ],
      ),
    );
  }
}

