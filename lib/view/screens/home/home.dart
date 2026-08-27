import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oro/apilink.dart';
import 'package:oro/controller/home/homeController.dart';
import 'package:oro/core/functions/databasetranslation.dart';
import 'package:oro/data/model/categoriesmodel.dart';
import 'package:oro/data/model/itemsmodel.dart';
import 'package:oro/view/widgets/home/categorieslist.dart';
import 'package:oro/view/widgets/home/discountcard.dart';
import 'package:oro/view/widgets/home/greeting.dart';
import 'package:oro/view/widgets/home/itemslist.dart';
import 'package:oro/view/widgets/home/product_section_rail.dart';
import 'package:oro/view/widgets/home/serch.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: GetBuilder<HomeControllerImp>(
        init: Get.isRegistered<HomeControllerImp>()
            ? Get.find<HomeControllerImp>()
            : Get.put(HomeControllerImp()),
        builder: (controller) {
          final promo = controller.mainPage.isNotEmpty
              ? controller.mainPage.first
              : null;
          final promoImage = promo?['mainpage_image']?.toString() ?? '';

          return CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              // ── 1. Barra de Búsqueda Flotante en la Parte Superior ──────
              SliverToBoxAdapter(
                child: SerchBar(
                  controller: controller.textEditingController,
                  onPressed: controller.goToSearch,
                  hint: 'search_products'.tr,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 6),
              ),

              // ── 2. Saludo Flotante de Bienvenida ──────────────────────
              SliverToBoxAdapter(
                child: Greeting(
                  name: controller.username ?? '',
                  img: controller.pfp,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 12),
              ),

              // ── 3. Carrusel Elegante de Promociones ───────────────────
              SliverToBoxAdapter(
                child: Discountcard(
                  title: databaseTranslation(
                    promo?['mainpage_title'],
                    promo?['mainpage_title_ar'],
                    promo?['mainpage_title_es'],
                  ),
                  content: databaseTranslation(
                    promo?['mainpage_body'],
                    promo?['mainpage_body_ar'],
                    promo?['mainpage_body_es'],
                  ),
                  image: promoImage.isEmpty
                      ? null
                      : CachedNetworkImageProvider(
                          "${AppLink.bannerimage}$promoImage",
                        ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 16),
              ),

              // ── 4. Categorías en chips flotantes ──────────────────────
              const SliverToBoxAdapter(
                child: Categorieslist(),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 18),
              ),

              // ── 5. Categorías Dinámicas de Productos (Rieles) ─────────
              ...controller.categories.asMap().entries.map((entry) {
                final index = entry.key;
                final category = entry.value;
                final catModel = CategoriesModel.fromJson(
                  Map<String, dynamic>.from(category),
                );
                final catItems = controller.items
                    .map((e) => ItemsModel.fromJson(e))
                    .where((item) =>
                        item.itemCat?.toString() ==
                        catModel.categoryId?.toString())
                    .toList();

                if (catItems.isEmpty) {
                  return const SliverToBoxAdapter(
                      child: SizedBox.shrink());
                }

                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ProductSectionRail(
                      category: catModel,
                      products: catItems,
                      onShowAll: () {
                        controller.goToItem(
                          controller.categories,
                          index,
                          catModel.categoryId?.toString() ?? '',
                        );
                      },
                      onProductTap: controller.goToItemDetails,
                    ),
                  ),
                );
              }),

              // ── 6. Todos los Productos (Grid Principal Masonry) ────────
              const SliverToBoxAdapter(
                child: ItemsList(),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: 100),
              ),
            ],
          );
        },
      ),
    );
  }
}
